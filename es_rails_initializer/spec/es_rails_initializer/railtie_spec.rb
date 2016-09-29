RSpec.describe EsRailsInitializer::Railtie do
  let(:app_mock_class) do
    Class.new do
      attr_accessor :root, :config

      def initialize
        self.root = Pathname.new(File.expand_path('../../fixtures/app_root', __FILE__))
        self.config = ::Rails::Railtie::Configuration.new
      end
    end
  end

  describe 'es_rails_initializer.load_config' do
    subject { EsRailsInitializer::Railtie.initializers[0] }

    it 'id named "es_rails_initializer.load_config"' do
      expect(subject.name).to eq 'es_rails_initializer.load_config'
    end

    describe '#run' do
      let(:app) { app_mock_class.new }
      before { subject.run(app) }

      it 'load YAML/ERB and set config' do
        expect(app.config.elasticsearch['host']).to eq 'localhost'
      end

      it 'creates config as HashWithIndifferentAccess' do
        expect(app.config.elasticsearch).to be_kind_of(HashWithIndifferentAccess)
      end
    end
  end

  describe 'es_rails_initializer.initialize_client' do
    subject { EsRailsInitializer::Railtie.initializers[1] }

    it 'is named "es_rails_initializer.initialize_client"' do
      expect(subject.name).to eq 'es_rails_initializer.initialize_client'
    end

    describe '#run' do
      let(:app) { app_mock_class.new }
      before { app.config.elasticsearch = { 'host' => 'localhost' } }
      before { subject.run(app) }

      it 'creates client' do
        expect(EsRailsInitializer.client).to be_a(Elasticsearch::Transport::Client)
      end

      it 'puts the client to elasticsearch-model/persistence default' do
        expect(Elasticsearch::Model.client).to be(EsRailsInitializer.client)
        expect(Elasticsearch::Persistence.client).to be(EsRailsInitializer.client)
      end
    end
  end
end
