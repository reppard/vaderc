$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require 'vaderc'
require 'pry'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end
