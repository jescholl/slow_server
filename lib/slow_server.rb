require "slow_server/version"
require "slow_server/server"
require "slow_server/client"
require "slow_server/config"

module SlowServer
  class << self

    def server
      @server ||= Server.new
    end

    def client
      @client ||= Client.new
    end

  end
end
