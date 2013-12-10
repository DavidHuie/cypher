module Cypher

  class CLI < Thor

    def self.client
      @client ||= Cypher::Client.new(Cypher.config.server_uri)
    end

    def self.check_for_login
      unless server_running?
        puts 'Please login first.'
        exit(1)
      end
    end

    def self.server_running?
      begin
        client.repo.data
      rescue DRb::DRbConnError
        return false
      end
      true
    end

    def self.get_input(description)
      print(description)
      $stdout.flush
      STDIN.gets.chomp
    end

    def self.get_password
      get_input('Enter your password: ')
    end

    desc 'login', 'Temporarily login'
    def login
      if self.class.server_running?
        puts 'Already logged in.'
        exit(0)
      end

      server = Server.new(Cypher.config.server_uri,
                          Cypher.config.server_ttl)

      if server.authenticate(Cypher.config.data_file_path,
                             self.class.get_password)
        puts 'Authenticated!'
        server.daemonize
        # Ensure that the server thread has started.
        sleep(0.1)
        exit(0)
      end

      # First time running this command
      unless server.repo.exists?
        puts "Please run `init` command first."
        exit(1)
      end

      puts 'Incorrect password.'
      exit(1)
    end

    desc 'logout', 'Logout'
    def logout
      # This should locate the pid file for the running daemon and kill it.
    end

    desc 'init', 'Create required files'
    def init
      if File.exists?(Cypher.config.data_file_path)
        puts 'Cypher already initialized.'
        exit(1)
      end

      server = Server.new(Cypher.config.server_uri,
                          Cypher.config.server_ttl)
      server.create_repo(Cypher.config.data_file_path,
                         self.class.get_password)

      puts "Password repository created."
    end

    desc 'status', 'Displays login status'
    def status
      if self.class.server_running?
        puts 'Logged in.'
      else
        puts 'Logged out.'
      end
    end

    desc 'pw SERVICE USER', 'Output the password for SERVICE with a login of USER'
    def pw(service, user)
      self.class.check_for_login
      client = self.class.client

      unless client.repo.service_exists?(service)
        puts "There aren't any passwords stored for service '#{service}'"
        exit(1)
      end

      unless client.repo.user_exists?(service, user)
        puts "There aren't any passwords stored for user '#{user}' for service '#{service}'"
        exit(1)
      end

      puts client.repo.get_password(service, user)
    end

    desc 'add_pw', 'Add a new password for a service'
    def add_pw
      self.class.check_for_login
      service = self.class.get_input('Enter the name of the service: ')
      username = self.class.get_input('Enter the username: ')
      password = self.class.get_input('Enter the password: ')
      client = self.class.client

      unless client.repo.data.include?(service)
        client.repo.data[service] = []
      end

      client.repo.set_password(service, username, password)
      client.repo.persist

      puts "Added password for '#{service}'"
    end

    desc 'list', 'Lists all data'
    def list
      self.class.check_for_login
      puts "Data: #{self.class.client.repo.data}"
    end
  end

end
