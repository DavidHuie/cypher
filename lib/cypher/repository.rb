module Cypher

  class Repository

    attr_accessor :data
    attr_reader :path, :hashed_password, :cipher

    def initialize(path, hashed_password)
      @path = path
      @hashed_password = hashed_password
      @cipher ||= Gibberish::AES.new(hashed_password)
    end

    def encrypted_data
      File.open(path) { |f| f.read }
    end

    def set_encrypted_data(enc_data)
      File.open(path, 'w') { |f| f.write(enc_data) }
    end

    def decrypt
      decrypted_data = cipher.dec(encrypted_data)
      self.data = JSON(decrypted_data)
    end

    def persist
      set_encrypted_data(cipher.enc(JSON.dump(data)))
    end

  end

end
