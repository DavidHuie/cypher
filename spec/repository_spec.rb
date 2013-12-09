require 'spec_helper'

describe Cypher::Repository do

  let(:klass) { Cypher::Repository }
  let(:file) { Tempfile.new('foo') }
  let(:path) { file.path }
  let(:repo) { klass.new(path, 'password') }

  it 'encrypts data on disk' do
    repo.data = { 'this data' => 'is encrypted' }
    repo.persist
    File.open(path) do |file|
      repo.cipher.dec(file.read).should eq("{\"this data\":\"is encrypted\"}")
    end
  end

  describe '#decrypt' do

    before(:each) do
      repo.data = { 'this data' => 'is encrypted' }
      repo.persist
    end

    it 'decrypts the data on disk' do
      repo.data = nil
      repo.decrypt
      repo.data.should eq({ "this data" => "is encrypted" })
    end

  end

end
