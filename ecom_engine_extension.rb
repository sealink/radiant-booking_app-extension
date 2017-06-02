# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

require 'tags/script_tags'

class EcomEngineExtension < Radiant::Extension
  version "1.0"
  description "This extension is communicating with Ecom Engine"
  url 'https://github.com/sealink/radiant-ecom_engine-extension'

  def activate
    Page.send :include, ScriptTags
  end

  def deactivate
  end
end
