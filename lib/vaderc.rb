require "vaderc/version"
require "vaderc/configuration"

module Vaderc
  class << self
    def run opts = {}
      @config ||= Vaderc::Configuration.new( opts )
    end
  end
end
