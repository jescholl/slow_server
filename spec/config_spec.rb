require 'spec_helper'

describe SlowServer::ServerConfig do
  let(:default){ double(port: 4000, chunks: 1, response_delay: 0, chunk_delay: 0) }

  let(:config){SlowServer::ServerConfig.new}
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
      port = Random.rand(1..1000)
      stub_const('ARGV', %W{ -p #{port} })
      expect{config.parse_opts}.to change{config.port}.from(default.port).to(port)
    end

    it 'should parse -c' do
      chunks = Random.rand(2..1000)
      stub_const('ARGV', %W{ -c #{chunks} })
      expect{config.parse_opts}.to change{config.chunks}.from(default.chunks).to(chunks)
    end

    it 'should parse -d' do
      response_delay = Random.rand(1..1000)
      stub_const('ARGV', %W{ -d #{response_delay} })
      expect{config.parse_opts}.to change{config.response_delay}.from(default.response_delay).to(response_delay)
    end

    it 'should parse -k' do
      chunk_delay = Random.rand(1..1000)
      stub_const('ARGV', %W{ -k #{chunk_delay} })
      expect{config.parse_opts}.to change{config.chunk_delay}.from(default.chunk_delay).to(chunk_delay)
    end

  end
end


describe SlowServer::ClientConfig do
  let(:default){ double(host: 'localhost', port: 4000, chunks: 1, response_delay: 0, chunk_delay: 0) }

  let(:config){SlowServer::ClientConfig.new}
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
      port = Random.rand(1000)
      stub_const('ARGV', %W{ -p #{port} example.com })
      expect{config.parse_opts}.to change{config.port}.from(default.port).to(port)
    end

    it 'should parse -c' do
      chunks = Random.rand(1000)
      stub_const('ARGV', %W{ -c #{chunks} example.com })
      expect{config.parse_opts}.to change{config.chunks}.from(default.chunks).to(chunks)
    end

    it 'should parse -d' do
      response_delay = Random.rand(1000)
      stub_const('ARGV', %W{ -d #{response_delay} example.com })
      expect{config.parse_opts}.to change{config.response_delay}.from(default.response_delay).to(response_delay)
    end

    it 'should parse -k' do
      chunk_delay = Random.rand(1000)
      stub_const('ARGV', %W{ -k #{chunk_delay} example.com })
      expect{config.parse_opts}.to change{config.chunk_delay}.from(default.chunk_delay).to(chunk_delay)
    end

    it 'should accept host from the URI' do
      host = "example.com"
      stub_const('ARGV', %W{ #{host} })
      expect{config.parse_opts}.to change{config.host}.from(default.host).to(host)
    end

    it 'should accept port from the URI' do
      port = Random.rand(1000)
      stub_const('ARGV', %W{ example.com:#{port} })
      expect{config.parse_opts}.to change{config.port}.from(default.port).to(port)
    end

  end
end

