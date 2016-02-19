Gem::Specification.new do |spec|
  spec.name          = "radiant-booking_app-extension"
  spec.version       = '0.0.1'
  spec.authors       = ["Michael Noack"]
  spec.email         = ["support@travellink.com.au"]
  spec.description   = %q{Integrate booking app with radiant}
  spec.summary       = %q{Integrate booking app with radiant}
  spec.homepage      = 'http://github.com/sealink/radiant-booking_app-extension'

  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'radius'
  spec.add_dependency 'rest-client'
  spec.add_dependency "radiant-domain-extension"

  spec.add_development_dependency "bundler", "~> 1.3"
end
