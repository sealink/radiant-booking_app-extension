require 'rest-client'

class RequestProxy
  def self.call(request, url, data, cookies)
    proxy = new(request, url, data, cookies)
    proxy.call
  end

  def initialize(request, url, data, cookies)
    @method  = request.method
    @url     = url
    @data    = data
    @cookies = cookies
    @headers = request.headers
  end

  def call
    options = {
      method:  @method,
      url:     url,
      cookies: @cookies,
      headers: headers_for_booking_app,
    }
    options[:payload] = @data unless http_get?

    RestClient::Request.execute(options) do |response, _request, _result, &_block|
      WrappedResponse.new(response)
    end
  end

  private

  def http_get?
    @method == :get
  end

  def url
    url = @url
    url += "?#{@data.to_query}" if http_get?
    url
  end

  def headers_for_booking_app
    {
      accept:           @headers['Accept'],
      referer:          @headers['HTTP_REFERER'],
      'X-CSRF-Token' => @headers['X-CSRF-Token']
    }
  end

  class WrappedResponse
    def initialize(response)
      @response = response
    end

    def redirect_location
      location_uri = URI.parse(@response.headers[:location])

      location = location_uri.path
      location += '?' + location_uri.query if location_uri.query.present?
      location += '#' + location_uri.fragment if location_uri.fragment.present?
      location
    end

    def code
      @response.code
    end

    def body
      @response.body
    end

    def cookies
      @response.cookies
    end

    def content_type
      @response.headers[:content_type]
    end

    def ok?
      (200..207).include? @response.code
    end

    def redirect?
      (300..399).include? @response.code
    end

  end
end
