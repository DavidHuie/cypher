module Cypher

  class Server

    attr_reader :uri, :repo, :timer, :ttl

    def initialize(uri, ttl)
      @uri = uri
      @ttl = ttl
      @timer = Timers.new
    end

    def authenticated?(repo_path, password)
      hashed_password = BCrypt::Password.create(password).to_s
      repo = Repository.new(repo_path, hashed_password)
      if repo.decrypt
        @repo = repo
        return true
      end
      false
    end

    def start_server
      DRb.start_service(uri, repo)
      timer.after(ttl) { DRb.stop_service }
      sleep(ttl)
    end

    def daemonize
      Daemons.call do
        start_server
        exit
      end
    end

  end

end
