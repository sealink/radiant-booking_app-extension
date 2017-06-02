module ScriptTags
  include Radiant::Taggable

  desc 'Econ-Engine javascript tag with the key for cache invalidation'
  tag 'ee_script_tag' do |tag|
    version_uri = "#{PageMountCalculator.new(@request).ecom_engine_url}/version.txt"
    response = Net::HTTP.get_response(URI.parse(version_uri))
    query = ''
    query = "?#{CGI::escape(response.body.strip)}" if response.is_a? Net::HTTPSuccess
    raw %{<script src="/ecom-engine-js/#{tag.attr['src']}#{query}"></script>}
  end
end
