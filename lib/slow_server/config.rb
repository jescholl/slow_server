require 'optparse'
require 'uri'

module SlowServer

  class Config
    attr_accessor :port, :chunks, :response_delay, :chunk_delay

    def initialize
      self.port = 4000
      self.chunks = 1
      self.response_delay = 0
      self.chunk_delay = 0
    end

    def opts
      @opts ||= OptionParser.new do |opt|
        opt.banner = "Usage: #{File.basename($PROGRAM_NAME)} [OPTIONS] [RESPONSE]"
        opt.on("-p", "--port NUMBER",            Integer, "Listen Port                         (default: #{self.port})")           { |v| self.port = v }
        opt.on("-c", "--chunks BYTES",           Integer, "Chunks                              (default: #{self.chunks})")         { |v| self.chunks = v }
        opt.on("-d", "--delay SECONDS",          Integer, "Transmission delay after connecting (default: #{self.response_delay})") { |v| self.response_delay = v }
        opt.on("-k", "--chunk-delay SECONDS",    Float,   "Delay between chunks                (default: #{self.chunk_delay})")    { |v| self.chunk_delay = v }
        opt.on("-v", "--version",                         "Show Version")                                                          { puts SlowServer::VERSION; throw :exit }
      end
    end

    def args
      opts.parse!
    end
  end

  class ServerConfig < Config
    attr_accessor :response_body

    def initialize
      super
      self.response_body = File.read(File.expand_path("../../../files/response.txt", __FILE__))
    end

    def parse
      response = args.join(" ")
      self.response_body = response unless response.empty?
    end
  end

  class ClientConfig < Config
    attr_accessor :request_method, :host, :request_uri, :request_headers

    def initialize
      super
      self.request_method = 'GET'
      self.host = 'localhost'
      self.request_uri = "/"
      self.request_headers = []
    end

    def opts
      opts = super
      opts.banner = "Usage: #{File.basename($PROGRAM_NAME)} [OPTIONS] [URI]"
      opts.on_head("-p", "--port NUMBER",            Integer, "Listen Port                         (default: #{self.port})")           { |v| @port_override = v }
      opts.on_head("-X", "--method METHOD",          String,  "Request Method                      (default: #{self.request_method})") { |v| self.request_method = v }
    end

    def parse
      uri = URI.parse(args[0])
      if !uri.respond_to?(:request_uri) && uri !~ %r{^\w+:\/\/}
        uri = URI.parse("http://#{uri}")
      end
      self.host = uri.host
      self.port = @port_override || uri.port
      self.request_uri = uri.request_uri if uri.request_uri
    end

  end
end
