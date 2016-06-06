require 'socket'

module SlowServer
  class Client

    def config
      SlowServer.config
    end

    def chunk_size
      (request.size / config.chunks.to_f).ceil
    end

    def chunks
      request.scan(/.{1,#{chunk_size}}/m)
    end

    def request
      "GET /"
    end

    def start
      TCPSocket.open("127.0.0.1", 4000) do |socket|
        STDERR.puts "Waiting for #{config.response_delay} seconds"
        sleep config.response_delay

        chunks.each do |chunk|
          STDERR.puts "Sending #{chunk_size} bytes"
          socket.print chunk
          STDERR.puts "Waiting for #{config.chunk_delay} seconds"
          sleep config.chunk_delay
        end
        socket.print("\r\n\r\n")

        response = socket.read
        headers,body = response.split("\r\n\r\n", 2)
        STDERR.puts "\n"
        print body
      end
    end

  end
end
