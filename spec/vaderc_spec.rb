require 'spec_helper'

describe Vaderc do
  it 'has a version number' do
    expect(Vaderc::VERSION).not_to be nil
  end

  describe 'Vaderc.run' do
    let(:options) {{
      server: 'localhost',
      port:   '6667'
    }}

    it "takes an options hash" do
      expect(Vaderc).to receive(:run).with(options)
      Vaderc.run(options)
    end

    it "creates a new configuration with options" do
      expect(Vaderc::Configuration).to receive(:new).with(options)
      Vaderc.run(options)
    end
  end
end
