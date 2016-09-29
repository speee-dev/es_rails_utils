lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'es_rails_initializer/version'

Gem::Specification.new do |s|
  s.name        = 'es_rails_initializer'
  s.version     = EsRailsInitializer::VERSION
  s.authors     = ['Hirokazu Nishioka']
  s.email       = ['hiro@nisshiee.org']
  s.homepage    = 'https://github.com/speee-dev/es_rails_utils/tree/master/es_rails_initializer'
  s.summary     = 'Railtie for elasticsearch client initialization'
  s.description =
    "EsRailsInitializer supports initialization of your elasticsearch client. \
You only have to add this gem in Gemfile and to write config/elasticsearch.yml."
  s.license     = 'MIT'

  s.files = Dir['lib/**/*', 'MIT-LICENSE', 'README.md']

  s.add_runtime_dependency 'railties', '>= 4.0.0'
  s.add_runtime_dependency 'activesupport', '>= 4.0.0'
  s.add_runtime_dependency 'elasticsearch-transport'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'yard'
end
