require 'socket'

module SlowServer
  class Server

    def config
      SlowServer.config
    end

    def server
      @server ||= TCPServer.open('0.0.0.0', config.port)
    end

    def chunks
      #config.response.unpack("a#{config.chunks}"*(config.response.size/config.chunks))
      config.response.scan(/.{1,#{config.chunk_size}}/m)
    end

    def start
      loop do
        Thread.start(server.accept) do |socket|

          STDERR.puts socket.gets
          STDERR.puts "Waiting for #{config.response_delay} seconds"
          sleep config.response_delay

          STDERR.puts "Sending response headers"

          socket.print "HTTP/1.1 200 OK\r\n" +
                       "Content-Type: text/plain\r\n" +
                       "Content-Length: #{config.response.bytesize}\r\n" +
                       "Connection: close\r\n\r\n"

          chunks.each do |chunk|
            STDERR.puts "Sending #{config.chunk_size} bytes"
            socket.print chunk
            STDERR.puts "Waiting for #{config.chunk_delay} seconds"
            sleep config.chunk_delay
          end

          socket.close
        end
      end
    end
  end
end
