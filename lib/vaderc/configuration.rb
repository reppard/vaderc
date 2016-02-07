module Vaderc
  class Configuration

    def self.keys
      [
        :port,
        :mode,
        :server,
        :nickname,
        :realname
      ]
    end

    attr_accessor(*keys)

    def initialize opts = {}
      self.options = defaults.merge(opts)
    end

    def options=(opts)
      opts.each{ |key, value| instance_variable_set("@#{key}", value) }
    end

    private
    def defaults
      {
        port:     ENV['VADERC_PORT']     ||'6667',
        mode:     ENV['VADERC_MODE']     || '8',
        server:   ENV['VADERC_SERVER']   || 'localhost',
        nickname: ENV['VADERC_NICKNAME'] || "vaderc#{Time.now.to_i}",
        realname: ENV['VADERC_REALNAME'] || "Vaderc User"
      }
    end
  end
end
