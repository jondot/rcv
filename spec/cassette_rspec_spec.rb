require 'rspec'
require 'rcv'


RSpec.configure do |config|
  config.include RCV::RSpec
end

describe "reverse play" do
  should_reverse_play 'fixtures/sample_cassette.yml'
end
