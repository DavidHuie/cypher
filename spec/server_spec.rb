require 'spec_helper'

describe Cypher::Server do

  let(:klass) { Cypher::Server }
  let(:uri) { 'druby://localhost:1234' }
  let(:server) { klass.new(uri, 2) }
  let(:file_path) { '/tmp/test_file' }

  describe '#authenticate' do

    it 'returns false if a repo does not exist or if a password is wrong' do
      server.authenticate(file_path, 'password').
        should be_false
    end

  end

end
