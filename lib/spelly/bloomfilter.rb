require File.join(File.dirname(__FILE__), "bitfield")

class BloomFilter
  attr_accessor :bitfield

  def initialize(bitfield_size)
    @bitfield = BitField.new(bitfield_size)
  end

  def hashes(item)
    [item.hash, item.crypt("42").hash, item.sum]
  end

  def add(item)
    field_size = @bitfield.length

    hashes(item.to_s).each do |item_hash|
      @bitfield[item_hash % field_size] = 1
    end
  end

  def includes?(item)
    field_size = @bitfield.length
    hashes(item).each do |item_hash|
      return false unless @bitfield[item_hash % field_size] == 1
    end
    true
  end

  def saturation
    @bitfield.saturation.to_f / @bitfield.length.to_f
  end

  def to_s
    @bitfield.to_s
  end
end