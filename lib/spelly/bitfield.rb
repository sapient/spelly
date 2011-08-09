class BitField
  include Enumerable

  attr_accessor :bits
  attr_reader :length

  WIDTH = 32

  def initialize(length)
    @bits = Array.new(1 + ((length - 1) / WIDTH), 0)
    @length = length
  end

  def []=(index, value)
    if value == 1
       @bits[index / WIDTH] |= 1 << (index % WIDTH)
    else
      @bits[index / WIDTH] ^= 1 << (index % WIDTH)
    end
  end

  def [](index)
    @bits[index / WIDTH] & 1 << (index % WIDTH) > 0 ? 1 : 0
  end

  def saturation
    @bits.inject(0) do |acc, byte|
      acc += byte & 1 and byte >>= 1 until byte == 0
      acc
    end
  end

  def to_s
    inject("") { |out, bit| out + bit.to_s  }
  end

  def each(&block)
    @length.times { |ind| yield self[ind]}
  end
end