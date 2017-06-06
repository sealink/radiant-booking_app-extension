Gem::Specification.new do |spec|
  spec.name          = "radiant-ecom_engine-extension"
  spec.version       = '0.3.0'
  spec.authors       = ["Michael Noack"]
  spec.email         = ["support@travellink.com.au"]
  spec.description   = %q{Integrate ecom engine with radiant}
  spec.summary       = %q{Integrate ecom engine with radiant}
  spec.homepage      = 'http://github.com/sealink/radiant-ecom_engine-extension'

  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'radius'
  spec.add_dependency 'rest-client', '1.7.2' # what kis-cms uses, 1.8 is last ruby 1.9 compatible but breaks cookies, 2.0 requires ruby 2.0
  spec.add_dependency 'radiant-layouts-extension' # radiant_layout

  spec.add_development_dependency "bundler", "~> 1.3"
end
