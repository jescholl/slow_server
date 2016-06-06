require 'optparse'

module SlowServer
  class Config
    attr_accessor :response, :port, :chunks, :response_delay, :chunk_delay

    def initialize
      # set defaults
      self.response = File.read(File.expand_path("../../../files/response.txt", __FILE__))
      self.port = 4000
      self.chunks = 1
      self.response_delay = 0
      self.chunk_delay = 0
    end

    def opts
      @opts ||= OptionParser.new do |opt|
        opt.banner = "Usage: #{File.basename($PROGRAM_NAME)} [OPTIONS] [RESPONSE]"
        opt.on("-p", "--port NUMBER",            Integer, "Listen Port                     (default: #{self.port}")            { |v| self.port = v }
        opt.on("-c", "--chunks BYTES",           Integer, "Chunks                          (default: #{self.chunks})")         { |v| self.chunks = v }
        opt.on("-r", "--response-delay SECONDS", Integer, "Response delay after connecting (default: #{self.response_delay})") { |v| self.response_delay = v }
        opt.on("-k", "--chunk-delay SECONDS",    Float,   "Delay between chunks            (default: #{self.chunk_delay})")    { |v| self.chunk_delay = v }
        opt.on("-v", "--version",                         "Show Version")                                                      { puts SlowServer::VERSION; throw :exit }
      end
    end

    def parse_opts
      response = opts.parse!.join(" ")
      self.response = response unless response.empty?
    end

  end
end
