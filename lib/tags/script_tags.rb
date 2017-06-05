module ScriptTags
  include Radiant::Taggable

  desc 'Ecom-Engine javascript tag with the key for cache invalidation'
  tag 'ee_script_tag' do |tag|
    version = EcomEngine::Version.new(PageMountCalculator.new(@request).ecom_engine_url)
    query = "?#{CGI::escape(version.value)}"
    raw %{<script src="/ecom-engine-js/#{tag.attr['src']}#{query}"></script>}
  end
end
