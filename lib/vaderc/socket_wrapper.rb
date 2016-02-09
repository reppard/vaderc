require 'socket'

module Vaderc
  # Vaderc::SocketWrapper
  class SocketWrapper
    attr_accessor :server, :port, :socket, :socket_class
    attr_reader   :connected
    alias :connected? connected

    def initialize(server, port = 6667, socket_class = TCPSocket)
      @server       = server
      @port         = port
      @connected    = false
      @socket       = nil
      @socket_class = socket_class
    end

    def connect
      @socket    = socket_class.new(@server, @port)
      @connected = true
    end

    def read
      @socket.readline.chomp("\r\n")
    end
  end
end
