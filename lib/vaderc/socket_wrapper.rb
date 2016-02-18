require 'socket'

module Vaderc
  # Vaderc::SocketWrapper
  class SocketWrapper
    attr_accessor :server, :port, :socket, :socket_class
    attr_reader   :connected
    alias :connected? connected

    def initialize(args = {})
      self.options = args
    end

    def options=(opts)
      defaults.merge(opts).each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def connect
      @socket    = socket_class.new(server, port)
      @connected = true
    end

    def read
      socket.readline.chomp("\r\n")
    end

    private

    def defaults
      {
        server:       'localhost',
        port:         6667,
        socket_class: TCPSocket,
        socket:       nil,
        connected:    false
      }
    end
  end
end
