require 'spec_helper'

describe SlowServer::Client do
  let(:client){SlowServer::Client.new}
  describe '#chunks' do
    it 'should work with 1 chunk' do
      expect(client.chunks.size).to eq(1)
    end

    it 'should split into chunks' do
      client.config.chunks = Random.rand(1..client.request_body.size)
      puts client.config.chunks
      expect(client.chunks.size).to be_within(1).of(client.config.chunks)
    end
  end
end

