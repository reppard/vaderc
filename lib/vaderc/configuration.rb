require 'yaml'

module Vaderc
  class Configuration

    def self.keys
      [
        :port,
        :mode,
        :server,
        :nickname,
        :realname,
        :config_filename
      ]
    end

    attr_accessor(*keys)

    def initialize opts = {}
      @config_filename = opts.fetch(:config_filename, "#{ENV['HOME']}/.vaderc/config.yml")
      local_opts       = load_local_config(@config_filename)
      opts             = opts.merge(local_opts)
      self.options     = defaults.merge(opts)
    end

    def load_local_config(filename)
      if File.exists?(filename)
        data = YAML::load(File.read(filename))
        data.instance_of?(Hash) ? data : {}
      else
        {}
      end
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
