require 'spec_helper'

describe SlowServer::Config do
  let(:default){ double(port: 4000, chunks: 1, response_delay: 0, chunk_delay: 0) }

  let(:config){SlowServer::Config.new}
  describe '#new' do
    it 'has default settings' do
      expect(config.port).to eq(default.port)
      expect(config.chunks).to eq(default.chunks)
      expect(config.response_delay).to eq(default.response_delay)
      expect(config.chunk_delay).to eq(default.chunk_delay)
    end
  end

  describe '#parse_opts' do
    it 'should parse -p' do
      stub_const('ARGV', %w{ -p 1000 })
      expect{config.parse_opts}.to change{config.port}.from(default.port).to(1000)
    end

  end
end

