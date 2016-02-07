require 'spec_helper'

describe Vaderc::Configuration do
  context "#initialize" do
    let(:configuration) { Vaderc::Configuration.new }

    describe "attributes" do
      it "has a default port" do
        expect(configuration.port).to eq('6667')
      end

      it "has a default mode" do
        expect(configuration.mode).to eq('8')
      end

      it "has a default server" do
        expect(configuration.server).to eq('localhost')
      end

      it "has a default nickname" do
        expect(configuration.nickname).to match(/vaderc\d+/)
      end

      it "has a default realname" do
        expect(configuration.realname).to match(/Vaderc User/)
      end

      it "can receive custom attributes" do
        config = Vaderc::Configuration.new(
          port:     '1138',
          mode:     '1999',
          server:   'localhost',
          nickname: 'dummy',
          realname: 'big dummy'
        )

        expect(config.port).to     eq('1138')
        expect(config.mode).to     eq('1999')
        expect(config.server).to   eq('localhost')
        expect(config.nickname).to eq('dummy')
        expect(config.realname).to eq('big dummy')
      end

      it "can override defaults with env vars" do
        allow(ENV).to receive(:[]).with('VADERC_PORT').and_return    ('1138')
        allow(ENV).to receive(:[]).with('VADERC_MODE').and_return    ('1999')
        allow(ENV).to receive(:[]).with('VADERC_SERVER').and_return  ('localhost')
        allow(ENV).to receive(:[]).with('VADERC_NICKNAME').and_return('tommy')
        allow(ENV).to receive(:[]).with('VADERC_REALNAME').and_return('tommy cool')

        expect(configuration.port).to     eq('1138')
        expect(configuration.mode).to     eq('1999')
        expect(configuration.server).to   eq('localhost')
        expect(configuration.nickname).to eq('tommy')
        expect(configuration.realname).to eq('tommy cool')
      end
    end
  end
end
