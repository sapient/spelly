require 'test/unit'
require File.join(File.dirname(__FILE__), "..", "lib", "spelly", "bloomfilter")

class TestBloomfilter < Test::Unit::TestCase

  def test_adding_to_bloom
    bloom = BloomFilter.new(100)
    assert_equal 0, bloom.saturation
    bloom.add("test")
    assert bloom.includes?("test")
    assert !bloom.includes?("test2"), "Should not include test2"
    bloom.add("test2")
    assert bloom.includes?("test2")

    saturation = bloom.saturation
    assert saturation > 0
    bloom.add("test3")
    assert saturation < bloom.saturation
  end
end
