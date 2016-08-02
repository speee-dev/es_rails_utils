module EsRailsInitializer
  class << self
    attr_accessor :client
  end
end

require_relative './es_rails_initializer/railtie' if defined?(Rails)
