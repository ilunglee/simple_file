$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'simple_file/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'simple_file'
  s.version     = SimpleFile::VERSION
  s.authors     = ['Nelson Lee']
  s.email       = ['ilung.me@gmail.com']
  s.homepage    = 'http://ilung.me.com'
  s.summary     = 'Simple File Import / Export'
  s.description = 'Provide simple functionalities for file import and export.'
  s.license     = 'MIT'
  s.files       = Dir['{lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_development_dependency 'awesome_print', '~> 1.6'
  s.add_development_dependency 'bundler', '~> 1.10'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'dotenv'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.3'
end
