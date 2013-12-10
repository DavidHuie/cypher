module Cypher

  class Config

    attr_accessor :data_file_path, :server_uri, :server_ttl, :server_port,
                  :server_host

    def initialize
      config = {}
      if File.exists?(config_path)
        config = YAML.load(File.open(config_path) { |f| f.read })
      end

      # Server configuration
      @server_host = config['server_host'] || 'localhost'
      @server_port = config['server_port'] || 9998
      @server_uri = "druby://#{server_host}:#{server_port}"
      @server_ttl = (config['server_ttl'] || 5 * 60).to_i

      # Repository configuration
      @data_file_path = config['data_file'] || File.join(ENV['HOME'], '.cypher_data')
    end

    def config_path
      File.join(ENV['HOME'], '.cypher_config')
    end

  end

end
