module Cypher

  class CLI < Thor

    desc 'login USER', 'temporarily login as USER'
    def login(user)
      config = Config.new
      server = Server.new(config.server_uri, config.server_ttl)
      server.daemonize
      sleep(1)
    end

    desc 'auth SERVICE USER', 'output the password for SERVICE with a login of USER'
    def auth(service, user); end

    desc 'gen SERVICE USER', 'generate a password for SERVICE with a login of USER'
    def gen(service, user); end

    desc 'list', 'lists all services and users'
    def list; end

    desc 'history', 'output history of passwords for SERVICE with under the USER login'
    def history(service, user); end

  end

end
