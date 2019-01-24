# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)

require "omnitrade_api/client/version"

Gem::Specification.new do |s|
  s.name        = "omnitrade_client"
  s.version     = OmniTradeAPI::Client::VERSION
  s.authors     = ["OmniTrade"]
  s.email       = ["contact@omnitrade.io"]
  s.homepage    = "https://github.com/OmniTrade/client-ruby"
  s.summary     = "A ruby client to access OmniTrade's API."
  s.description = "A ruby client which can access all OmniTrade's API."
  s.license     = 'Apache License 2.0'

  s.require_paths = ["lib"]
  s.files = Dir["{bin,lib}/**/*"] + ["README.md"]

  s.add_runtime_dependency 'faye-websocket', '~> 0.9.2'
  s.add_development_dependency 'rspec', '~> 3.7.0'
end
