require 'active_support/core_ext/hash/indifferent_access'

module EsRailsInitializer
  class Railtie < ::Rails::Railtie
    initializer 'es_rails_initializer.load_config' do |app|
      yaml = app.root.join('config', 'elasticsearch.yml')
      config = YAML.load(ERB.new(yaml.read).result).with_indifferent_access
      app.config.elasticsearch = config[::Rails.env]
    end

    initializer 'es_rails_initializer.initialize_client', after: 'es_rails_initializer.load_config' do |app|
      options = app.config.elasticsearch.merge(logger: Rails.logger)
      EsRailsInitializer.client = Elasticsearch::Client.new(options)

      if defined?(Elasticsearch::Model) && Elasticsearch::Model.respond_to?(:client=)
        Elasticsearch::Model.client = EsRailsInitializer.client
      end
      if defined?(Elasticsearch::Persistence) && Elasticsearch::Persistence.respond_to?(:client=)
        Elasticsearch::Persistence.client = EsRailsInitializer.client
      end
    end
  end
end
