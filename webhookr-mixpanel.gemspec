# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webhookr-mixpanel/version'

Gem::Specification.new do |gem|
  gem.name          = "webhookr-mixpanel"
  gem.version       = Webhookr::Mixpanel::VERSION
  gem.authors       = ["Jodi J. Showers"]
  gem.email         = ["jodi@lifetales.com"]
  gem.description   = "A webhookr extension to support Mixpanel webhooks."
  gem.summary       = gem.description
  gem.homepage      = "http://github.com/jshow/webhookr-mixpanel"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("webhookr")
  gem.add_dependency("activesupport", [">= 3.1"])
end
