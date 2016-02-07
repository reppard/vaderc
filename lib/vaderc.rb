require "vaderc/version"
require "vaderc/configuration"
require "vaderc/socket_wrapper"

module Vaderc
  class << self
    def run opts = {}
      @config ||= Vaderc::Configuration.new( opts )
    end
  end
end
