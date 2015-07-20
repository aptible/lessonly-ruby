require 'webmock/rspec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'lessonly'
require 'support/fake_lessonly'

WebMock.disable_net_connect!

RSpec.configure do |c|
  c.before(:example) do
    WebMock.stub_request(:any, /api.lesson.ly/).to_rack(FakeLessonly)
  end
end
