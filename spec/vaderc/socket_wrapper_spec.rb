require 'spec_helper'

describe Vaderc::SocketWrapper do
  describe "::new" do
    let(:socket_wrapper) { Vaderc::SocketWrapper.new('localhost')}

    it 'should return a Vaderc::SocketWrapper' do
      expect(socket_wrapper.class).to eq(Vaderc::SocketWrapper)
    end

    it 'has a server attribute' do
      expect(socket_wrapper.server).to eq('localhost')
    end

    it 'has a port attribute with default' do
      expect(socket_wrapper.port).to eq(6667)
    end

    it 'should set socket instance to nil' do
      expect(socket_wrapper.socket).to eq(nil)
    end

    it 'has a socket_class attribute with default' do
      expect(socket_wrapper.socket_class).to eq(TCPSocket)
    end

    it 'should not be connected by default' do
      expect(socket_wrapper.connected?).to be false
    end
  end

  describe "#connect" do
    let(:socket_wrapper) { Vaderc::SocketWrapper.new('localhost') }

    it 'should set connected to true' do
      socket_wrapper.connect
      expect(socket_wrapper.connected?).to be true
    end

    it 'should new up socket_class' do
      socket_wrapper.socket_class = StringIO
      expect(socket_wrapper.socket_class).to receive(:new)
      socket_wrapper.connect
    end
  end

  describe "#read" do
    let(:socket_wrapper) { Vaderc::SocketWrapper.new('localhost') }

    it 'should read from socket and chomp CRLF' do
      socket_wrapper.socket = StringIO.new("test string\r\n")
      expect(socket_wrapper.read).to eq("test string")
    end
  end
end
