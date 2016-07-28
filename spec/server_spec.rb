require 'spec_helper'

describe SlowServer::Server do
  let(:server){SlowServer::Server.new}
  describe '#chunks' do
    it 'should work with 1 chunk' do
      expect(server.chunks.size).to eq(1)
    end

    it 'should split into chunks' do
      server.config.chunks = Random.rand(1..server.config.response_body.size)
      expect(server.chunks.size).to be_within(1).of(server.config.chunks)
    end
  end
end

