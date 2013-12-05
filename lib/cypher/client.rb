module Cypher

  class Client

    attr_reader :uri, :repo

    def initialize(uri)
      DRb.start_service
      @repo = DRbObject.new_with_uri(uri)
    end

  end

end
