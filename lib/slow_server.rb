require "slow_server/version"
require "slow_server/server"
require "slow_server/client"
require "slow_server/config"

module SlowServer
  class << self

    def server_config
      @server_config ||= ServerConfig.new
    end

    def client_config
      @client_config ||= ClientConfig.new
    end

  end
end
