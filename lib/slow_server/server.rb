require 'socket'

module SlowServer
  class Server

    def config
      @config ||= ServerConfig.new
    end

    def server
      @server ||= TCPServer.open('0.0.0.0', config.port)
    end

    def chunk_size
      (config.response_body.size / config.chunks.to_f).round
    end


    def chunks
      #config.response_body.scan(/.{1,#{chunk_size}}/m)
      # NOTE: to be accurate, chunk_size needs to be variable, or at least increase in a giant burst at the end
      #

      offset = 0
      length = 0
      out = []
      config.chunks.times do |i|
        length = ((config.response_body.size - out.join.size) / (config.chunks - i).to_f).floor
        out << config.response_body[offset..(offset+length)]
        offset += length + 1
      end
      out
    end


    def response_headers
      [].tap do |h|
        h << "HTTP/1.1 200 OK"
        h << "Content-Type: text/plain"
        h << "Content-Length: #{config.response_body.size}"
        h << "Connection: close"
      end
    end

    def get_request(socket)
      STDERR.puts socket.gets
      STDERR.puts "Waiting for #{config.response_delay} seconds"
    end

    def send_response(socket)
      STDERR.puts "Sending response headers"
      socket.print response_headers.join("\n")
      socket.print "\r\n\r\n"
      chunks.each do |chunk|
        STDERR.puts "Sending #{chunk_size} bytes"
        socket.print chunk
        STDERR.puts "Waiting for #{config.chunk_delay} seconds"
        sleep config.chunk_delay
      end
    end

    def start
      loop do
        Thread.start(server.accept) do |socket|
          STDERR.puts "Accepted Connection"
          # NOTE: consider putting a delay in here too
          get_request(socket)

          sleep config.response_delay

          send_response(socket)
          STDERR.print "\n"
          socket.close
        end
      end
    end
  end
end
