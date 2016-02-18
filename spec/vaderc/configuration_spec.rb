require 'spec_helper'

describe Vaderc::Configuration do
  context '#initialize' do
    describe 'attributes' do
      let(:configuration) { Vaderc::Configuration.new }

      it 'has a default port' do
        expect(configuration.port).to eq('6667')
      end

      it 'has a default mode' do
        expect(configuration.mode).to eq('8')
      end

      it 'has a default server' do
        expect(configuration.server).to eq('localhost')
      end

      it 'has a default nickname' do
        expect(configuration.nickname).to match(/vaderc\d+/)
      end

      it 'has a default realname' do
        expect(configuration.realname).to match(/Vaderc User/)
      end

      it 'can receive custom attributes' do
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

      it 'can override defaults with env vars' do
        stub_const(
          'ENV',
          'VADERC_PORT'     => '1138',
          'VADERC_MODE'     => '1999',
          'VADERC_SERVER'   => 'localhost',
          'VADERC_NICKNAME' => 'tommy',
          'VADERC_REALNAME' => 'tommy cool'
        )

        expect(configuration.port).to     eq('1138')
        expect(configuration.mode).to     eq('1999')
        expect(configuration.server).to   eq('localhost')
        expect(configuration.nickname).to eq('tommy')
        expect(configuration.realname).to eq('tommy cool')
      end
    end

    context 'config_filename' do
      let(:configuration) do
        Vaderc::Configuration.new(config_filename: 'config.yml')
      end

      it 'has a default config_filename' do
        stub_const('ENV', 'HOME' => '/home/user')

        configuration = Vaderc::Configuration.new
        expect(configuration.config_filename)
          .to eq('/home/user/.vaderc/config.yml')
      end

      it 'can specifiy config_filename' do
        expect(configuration.config_filename).to eq('config.yml')
      end

      describe 'config_filename exists' do
        before do
          allow(File).to receive('exist?').with('config.yml') { true }
          allow(File).to receive('read').with('config.yml') { content }
        end

        let(:content) do
          <<-'.'
            :server: localhost
            :mode: 8
            :port: 6668
            :nickname: testUser
            :realname: Real User
          .
        end

        it 'uses file if config_filename exists' do
          expect(configuration.mode).to     eq(8)
          expect(configuration.port).to     eq(6668)
          expect(configuration.server).to   eq('localhost')
          expect(configuration.nickname).to eq('testUser')
          expect(configuration.realname).to eq('Real User')
        end

        describe '#load_local_config' do
          it 'returns a hash' do
            expected = {
              server:  'localhost',
              mode:     8,
              port:     6668,
              nickname: 'testUser',
              realname: 'Real User'
            }

            hash = configuration.load_local_config('config.yml')

            expect(hash).to be_kind_of(Hash)
            expect(hash).to eq(expected)
          end

          it 'returns empty hash if config_file is invalid yaml' do
            allow(File).to receive('read').with('config.yml') { 'bad_content' }
            expect(configuration.load_local_config('config.yml')).to eq({})
          end
        end
      end
    end
  end
end
