module Cypher

  class CLI < Thor

    desc 'login', 'temporarily login'
    def login
      server = Server.new(Cypher.config.server_uri,
                          Cypher.config.server_ttl)
      server.daemonize
      sleep(1)
    end

    # Generate salt
    desc 'init', 'create required cypher files'
    def init; end

    desc 'pw SERVICE USER', 'output the password for SERVICE with a login of USER'
    def pw(service, user); end

    desc 'gen_pw SERVICE USER', 'generate a password for SERVICE with a login of USER'
    def gen_pw(service, user); end

    desc 'list', 'lists all services and users'
    def list; end
  end

end
