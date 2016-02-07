require 'socket'

module Vaderc
  class SocketWrapper

    attr_accessor :server, :port, :socket, :socket_class

    def initialize(server, port=6667, socket_class=TCPSocket)
      @server       = server
      @port         = port
      @connected    = false
      @socket       = nil
      @socket_class = socket_class
    end

    def connected?
      @connected
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
