module Cypher

  class Config

    attr_accessor :data_file, :server_uri, :server_ttl, :server_port,
                  :server_host

    def initialize
      config = {}
      if File.exists?(path)
        config = YAML.load(File.open(path) { |f| f.read })
      end

      # Server configuration
      @server_host = config['server_host'] || 'localhost'
      @server_port = config['server_port'] || 9998
      @server_uri = 'druby://#{server_host}:#{server_port}'
      @server_ttl = (config['server_ttl'] || 5 * 60).to_i

      # Repository configuration
      @data_file = config['data_file'] || File.join(ENV['HOME'], '.cypher_data')
    end

    def path
      File.join(ENV['HOME'], '.cypher_config')
    end

  end

end
