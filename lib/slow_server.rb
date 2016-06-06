require "slow_server/version"
require "slow_server/server"
require "slow_server/client"
require "slow_server/config"

module SlowServer
  class << self

    def config
      @config ||= Config.new
    end

    def configure
      yield config
    end

    def configure!
      @config = Config.new
      yield config
    end

  end
end
