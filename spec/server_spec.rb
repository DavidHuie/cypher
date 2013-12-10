require 'spec_helper'

describe Cypher::Server do

  let(:klass) { Cypher::Server }
  let(:uri) { 'druby://localhost:1234' }
  let(:server) { klass.new(uri, 2) }
  let(:file) { Tempfile.new('new_test') }

  describe '#authenticate' do

    it 'returns false if a repo does not exist or if a password is wrong' do
      server.authenticate(file.path, 'password').
        should be_false
    end

  end

end
