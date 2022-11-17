class Item
  attr_reader :name, :quality, :sell_in

  def initialize(name, sell_in, quality)
    @name, @sell_in, @quality = name, sell_in, quality
  end

  def tick
    case name
    when 'normal'
      return normal_tick
    when 'Aged Brie'
      return brie_tick
    when 'Sulfuras, Hand of Ragnaros'
      return sulfuras_tick
    when 'Backstage passes to a TAFKAL80ETC concert'
      return backstage_tick
    end
  end

  # initial method making test pass green again
  # def normal_tick
  #   if @quality != 0
  #     if @sell_in > 0
  #       @quality -= 1
  #     elsif @sell_in <= 0
  #       @quality -= 2
  #     end
  #   end
  #   @sell_in -= 1
  # end

  # DRY method making test pass green
  def normal_tick
    @sell_in -= 1
    return if @quality == 0

    @quality -= 1
    @quality -= 1 if @sell_in <= 0
  end

  def brie_tick
    @sell_in -= 1
    return @quality = 50 if @quality == 49
    return if @quality >= 50

    @quality += 1
    @quality += 1 if @sell_in <= 0
  end

  def sulfuras_tick
  end

  def backstage_tick
    @sell_in -= 1
    return if @quality >= 50
    return @quality = 0 if @sell_in < 0

    @quality += 1
    @quality += 1 if @sell_in < 10
    @quality += 1 if @sell_in < 5
  end
end

def update_quality(items)
  items.each(&:tick)
end
