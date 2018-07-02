require 'bundler/setup'
Bundler.setup

require 'ap'
require 'webmock/rspec'
require 'byebug'
require 'file_utility'
require 'vcr'

# # https://github.com/codeclimate/ruby-test-reporter#webmocknetconnectnotallowederror
# WebMock.disable_net_connect!(allow: 'codeclimate.com')

# Square.access_token = 'whatever man'

Dir['./spec/support/**/*.rb'].each { |f| require f }