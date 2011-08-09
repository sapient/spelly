require 'minitest/autorun'
require 'minitest/pride'

require File.join(File.dirname(__FILE__), "..", "lib", "spelly", "bitfield")

class TestBitField < MiniTest::Unit::TestCase

  def setup
    super
  end

  def test_zero_initialization
    bf = BitField.new(10)
    assert_equal bf.length, 10
    assert_equal bf[0], 0
    assert_equal bf[1], 0
    assert_equal bf[2], 0
    assert_equal bf[3], 0
    assert_equal bf[4], 0
    assert_equal bf[5], 0
    assert_equal bf[6], 0
    assert_equal bf[7], 0
    assert_equal bf[8], 0
    assert_equal bf[9], 0
  end

  def test_saturation_calculation
    bf = BitField.new(1000)
    assert_equal 1000, bf.length
    assert_equal 0, bf.saturation
    bf[0] = 1
    bf[2] = 1
    bf[4] = 1
    assert_equal 3, bf.saturation
    bf[6] = 1
    bf[68] = 1
    bf[34] = 1
    assert_equal 6, bf.saturation
  end

  def test_bit_setting
    bf = BitField.new(1000)
    bf[0] = 1
    bf[32] = 1
    bf[33] = 1
    bf[999] = 1

    assert_equal 1, bf[0]
    assert_equal 0, bf[1]
    assert_equal 1, bf[32]
    assert_equal 1, bf[33]
    assert_equal 1, bf[999]
  end

end