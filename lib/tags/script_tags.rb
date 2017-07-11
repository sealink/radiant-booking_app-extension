module ScriptTags
  include Radiant::Taggable

  desc 'Ecom-Engine javascript tag with the key for cache invalidation'
  tag 'ee_script_tag' do |tag|
    version = EcomEngine::Version.new(PageMountCalculator.new(@request).ecom_engine_url)
    query = "?#{CGI::escape(version.value)}"
    raw %{<script src="/ecom-engine-js/#{tag.attr['src']}#{query}"></script>}
  end

  desc 'Ecom-Engine javascript bundle'
  tag 'ee_bundle_tag' do |tag|
    bundle_url = PageMountCalculator.new(@request).ecom_engine_url + "/app_cells?name=header/#{tag.attr['name']}"
    uri = URI.parse(bundle_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'
    response = http.get uri.request_uri
    raw response.body.strip
  end
end
