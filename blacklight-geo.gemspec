# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blacklight/geo/version'

Gem::Specification.new do |spec|
  spec.name          = "blacklight-geo"
  spec.version       = Blacklight::Geo::VERSION
  spec.authors       = ["Darren Hardy", "Jack Reed"]
  spec.email         = ["drh@stanford.edu", "pjreed@stanford.edu"]
  spec.summary       = %q{GeoBlacklight}
  spec.homepage      = "http://github.com/sul-dlss/geoblacklight"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_dependency "blacklight", ">= 5.1.0"
  spec.add_dependency "bootstrap-sass", "~> 3.0"
  spec.add_dependency "leaflet-rails"
  spec.add_dependency "leaflet-markercluster-rails"
  spec.add_dependency "leaflet-sidebar-rails", "~> 0.0.2"
  spec.add_dependency 'blacklight_range_limit'
  spec.add_dependency 'font-awesome-sass'
  spec.add_dependency 'httparty'
  
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "jettywrapper"
  spec.add_development_dependency "engine_cart", "~> 0.3.2"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "poltergeist", ">= 1.5.0"
end
