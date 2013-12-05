module Cypher

  class Repository

    attr_accessor :data
    attr_reader :path, :hashed_password

    def initialize(path, hashed_password)
      @path = path
      @hashed_password = hashed_password
    end

    def decrypt
      encrypted_data = File.open(path) { |f| f.read }
      decrypted_data = cipher.dec(encrypted_data)
      self.data = JSON(decrypted_data)
    end

    def persist
      encrypted_data = cipher.enc(JSON.dump(data))
      File.open(path, 'w') { |f| f.write(encrypted_data) }
    end

    private

    def cipher
      @cipher ||= Gibberish::AES.new(hashed_password)
    end

  end

end
