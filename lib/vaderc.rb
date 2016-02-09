require 'vaderc/version'
require 'vaderc/configuration'
require 'vaderc/socket_wrapper'

# Vaderc Module
module Vaderc
  class << self
    def run(opts = {})
      @config ||= Vaderc::Configuration.new( opts )
    end
  end
end
