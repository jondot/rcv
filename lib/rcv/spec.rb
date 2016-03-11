module RCV
  module Spec
    def make_expectation
      raise "implement this"
    end

    module ClassMethods
      def should_reverse_play(cassette_file)
        describe "cassette: #{cassette_file}" do
          results = RCV::Cassette.new(cassette_file).reverse_play
          results.each_with_index  do |(request, actual, expected), i|
            describe "#{i}: #{request[:method]} #{request[:url]}" do
              it "should match status" do
                make_expectation(*[actual, expected].map{|h| h[:status]})
              end
              it "should match headers" do
                expected[:headers].each do |k,v|
                  make_expectation actual[:headers][k], v
                end
              end
              it "should match body" do
                make_expectation(*[actual, expected].map{|h| h[:body]})
              end
            end
          end
        end
      end
    end
  end

  module MiniTest
    include Spec
    def self.included(base)
      base.extend(self::ClassMethods)
    end
    def make_expectation(actual, expected)
      actual.must_equal(expected)
    end
  end

  module RSpec
    include Spec
    def self.included(base)
      base.extend(self::ClassMethods)
    end
    def make_expectation(actual, expected)
      expect(actual).to eq(expected)
    end
  end
end
