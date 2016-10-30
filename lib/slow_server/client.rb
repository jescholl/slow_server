require 'socket'
require 'uri'

module SlowServer
  class Client

    def config
      @config ||= ClientConfig.new
    end

    def chunk_size
      (request_body.size / config.chunks.to_f).round
    end

    def chunks
      request_body.scan(/.{1,#{chunk_size}}/m)
    end

    def request_body
      [].tap do |req|
        req << [config.request_method, config.request_uri].join(" ")
        req << config.request_headers
      end.join("\n")
    end

    def send_request(socket)
      chunks.each do |chunk|
        STDERR.puts "Sending #{chunk_size} bytes"
        socket.print chunk
        STDERR.puts "Waiting for #{config.chunk_delay} seconds"
        sleep config.chunk_delay
      end
      socket.print("\r\n\r\n")
    end

    def get_response(socket)
      response = socket.read
      _headers,body = response.split("\r\n\r\n", 2)
      STDERR.puts "\n"
      print body
    end

    def start
      TCPSocket.open(config.host, config.port) do |socket|
        STDERR.puts "Waiting for #{config.response_delay} seconds"
        sleep config.response_delay
        send_request(socket)
        get_response(socket)
      end
    end

  end
end
