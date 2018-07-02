require 'bundler/setup'
Bundler.setup

require 'ap'
require 'byebug'
require 'tempfile'
require 'simple_file'

Dir['./spec/support/**/*.rb'].each { |f| require f }