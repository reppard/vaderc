require 'spec_helper'

describe Vaderc::Configuration do
  context "#initialize" do
    describe "attributes" do
      let(:configuration) { Vaderc::Configuration.new }

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
        stub_const('ENV',{
          'VADERC_PORT'     => '1138',
          'VADERC_MODE'     => '1999',
          'VADERC_SERVER'   => 'localhost',
          'VADERC_NICKNAME' => 'tommy',
          'VADERC_REALNAME' => 'tommy cool'})

        expect(configuration.port).to     eq('1138')
        expect(configuration.mode).to     eq('1999')
        expect(configuration.server).to   eq('localhost')
        expect(configuration.nickname).to eq('tommy')
        expect(configuration.realname).to eq('tommy cool')
      end
    end

    context "config_filename" do
      let(:configuration) { Vaderc::Configuration.new }

      it "has a default config_filename" do
        stub_const('ENV', {'HOME' => '/home/user'})
        expect(configuration.config_filename).to eq("/home/user/.vaderc/config.yml")
      end

      it "can specifiy config_filename" do
        configuration = Vaderc::Configuration.new({config_filename: 'config.yml'})
        expect(configuration.config_filename).to eq('config.yml')
      end

      describe "config_filename exists" do
        it "uses file if config_filename exists" do
          content = <<-"."
            :server: localhost
            :mode: 8
            :port: 6668
            :nickname: testUser
            :realname: Real User
          .

          allow(File).to receive('exists?').with('config.yml'){ true }
          allow(File).to receive('read').with('config.yml'){ content }
          configuration = Vaderc::Configuration.new({config_filename: 'config.yml'})

          expect(configuration.mode).to     eq(8)
          expect(configuration.port).to     eq(6668)
          expect(configuration.server).to   eq('localhost')
          expect(configuration.nickname).to eq('testUser')
          expect(configuration.realname).to eq('Real User')
        end
      end
    end
  end

  describe "#load_local_config" do
    let(:configuration){Vaderc::Configuration.new(
      {config_filename: 'config.yml'}
    )}

    it "returns a hash" do
      content = <<-"."
        :server: localhost
        :mode: 8
        :port: 6668
        :nickname: testUser
        :realname: Real User
      .

      expected = {
        server:  'localhost',
        mode:     8,
        port:     6668,
        nickname: 'testUser',
        realname: 'Real User'
      }

      allow(File).to receive('exists?').with('config.yml').and_return(true)
      allow(File).to receive('read').with('config.yml').and_return(content)

      hash = configuration.load_local_config('config.yml')
      expect(hash).to eq(expected)
    end

    it "returns empty hash if config_file is invalid yaml" do
      content = <<-"."
        dumbdata
      .

      allow(File).to receive('exists?').with('config.yml').and_return(true)
      allow(File).to receive('read').with('config.yml').and_return(content)

      hash = configuration.load_local_config('config.yml')
      expect(hash).to eq({})
    end
  end
end
