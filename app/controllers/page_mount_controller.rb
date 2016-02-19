class PageMountController < SiteController
  BOOKING_APP_URL = Yamload::Loader.new('booking-app').content['url']

  no_login_required

  radiant_layout { |controller| controller.domains_layout }

  before_filter :set_monitoring_meta_data, only: :proxy

  # Example:
  #  /accommodation/kangaroo-island/ozone-12?adults=1
  #
  # params[:paths]  => ["kangaroo-island", "ozone-12"]
  # params[:adults] => 1
  def proxy
    response = http_proxy(BOOKING_APP_URL + request.path)

    # TODO: Resolve so that response doesn't return blank for cookies on 500?
    # ... or determine if having blank cookies means "don't set anything buddy"
    session[:proxied_cookies] = response.cookies unless response.cookies.blank?

    if response.redirect?
      redirect_to response.redirect_location
      return
    end

    unless response.ok?
      Rails.logger.error("Booking-app proxy failed. Response [#{response.code}] =>")
      Rails.logger.error(response.body)
      # TODO: Contact errbit? Can we improve this fail page...?
      #
      # This is rendered in booking-app: 'shared/quicktravel_unavailable'
      # Probably, it should be here!
    end

    proxy_response = ProxyResponse.new(response)
    if proxy_response.file?
      send_file(proxy_response)
    else
      @title = proxy_response.headers[:x_title]
      render text:         proxy_response.body,
             content_type: proxy_response.content_type,
             status:       proxy_response.code,
             layout:       true
    end
  end

  # Layout from params,
  # with domain_key interpolation for multi-site support
  def domains_layout
    layout = params.fetch(:layout, 'content-wide')
    format(layout, domain_key: domain_key)
  end

  private

  def domain_key
    domain = Domain.new(request)
    domain.key
  end

  def http_proxy(url)
    RequestProxy.call(request, url, params, session[:proxied_cookies])
  end

  def set_monitoring_meta_data
    return unless defined?(NewRelic)
    controller, action = extract_controller_action(request, params)
    NewRelic::Agent.set_transaction_name("page_mount:#{controller}/#{action}")
  end

  def extract_controller_action(request, params)
    if request.path == '/cells'
      params[:name].split('/', 2)
    else
      *parts, action = request.path[1..-1].split('/')
      [parts.join('/'), action]
    end
  end

  # TODO: Check if we can delete this...
  def protect_against_forgery?
    false
  end

  def send_file(proxy_response)
    send_data proxy_response.body,
              type:        proxy_response.content_type,
              disposition: proxy_response.content_disposition
  end

  class ProxyResponse
    DEFAULT_CONTENT_DISPOSITION = 'inline'

    attr_reader :response

    def initialize(response)
      @response = response
    end

    def file?
      headers.key?(:content_disposition) || headers[:content_type] == 'application/octet-stream'
    end

    def content_disposition
      headers[:content_disposition] || DEFAULT_CONTENT_DISPOSITION
    end

    delegate :body, :content_type, :code, to: :response

    def headers
      @response.body.headers
    end
  end
end
