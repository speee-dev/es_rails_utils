Bundler.require(:test)

module Rails
  def self.env
    'test'
  end

  def self.logger
    nil
  end
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'es_rails_initializer'
