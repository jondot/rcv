require 'rcv'
require 'minitest/spec'
require 'minitest/autorun'

describe "reverse play" do
  include RCV::MiniTest

  should_reverse_play 'fixtures/sample_cassette.yml'
end

