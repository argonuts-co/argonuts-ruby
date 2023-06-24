$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), "lib"))

require "argonuts/version"

Gem::Specification.new do |gem|
  gem.name        = "argonuts-ruby"
  gem.version     = Argonuts::VERSION
  gem.summary     = "Client library provides access to the Argonuts API (argonuts.co)"
  gem.description = "Official client library to the Argonuts API (argonuts.co)"
  gem.author      = "Argonuts"
  gem.email       = "admin@argonuts.co"
  gem.homepage    = "https://argonuts.co"
  gem.license     = "MIT"
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- test/*`.split("\n")
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "http"

  gem.add_dependency "rest-client"
end
