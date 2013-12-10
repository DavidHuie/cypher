module Cypher

  class Repository

    attr_accessor :data
    attr_reader :path, :hashed_password, :cipher

    def initialize(path, hashed_password)
      @path = path
      @hashed_password = hashed_password
      @cipher = Gibberish::AES.new(hashed_password)
    end

    def bootstrap
      self.data = {}
      persist
    end

    def exists?
      File.exists?(path)
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

    def set_password(service_name, username, password)
      unless data[service_name]
        data[service_name] = []
      end

      data[service_name] << [username, password]
      data[service_name].uniq!
    end

    def service_exists?(service_name)
      data.include?(service_name)
    end

    def user_exists?(service_name, user)
      users = data[service_name].map { |d| d[0] }.uniq
      users.include?(user)
    end

    def get_password(service_name, user)
      data[service_name].select { |d| d[0] == user }.
        map { |d| d[1] }.last
    end

  end

end
