require 'spec_helper'

describe Cypher::Client do

  let(:uri) { 'druby://localhost:4545' }
  let(:client) { Cypher::Client.new(uri) }
  let(:file) { Tempfile.new('foo') }
  let(:server) { Cypher::Server.new(uri, 2) }

  before(:each) do
    server.create_repo(file.path, 'password')
    server.authenticate(file.path, 'password')
    @thread = Thread.new { server.start_server }
    sleep(0.01)
  end

  after(:each) { @thread.kill }

  it 'passes data back to the server' do
    client.repo.data = { 'this' => 'is test data'}
    server.repo.data.should eq({ "this" => "is test data" })
  end

end
