class Item
  attr_reader :name, :quality, :sell_in

  def initialize(name, sell_in, quality)
    @name, @sell_in, @quality = name, sell_in, quality
  end

  def tick
    case name
    when 'normal'
      @item = Normal.new(sell_in, quality)
      @item.tick
    when 'Aged Brie'
      @item = Brie.new(sell_in, quality)
      @item.tick
    when 'Sulfuras, Hand of Ragnaros'
      @item = Sulfuras.new(sell_in, quality)
      @item.tick
    when 'Backstage passes to a TAFKAL80ETC concert'
      @item = Backstage.new(sell_in, quality)
      @item.tick
    end
  end

  class Normal
    attr_reader :quality, :sell_in

    def initialize(sell_in, quality)
      @sell_in, @quality = sell_in, quality
    end

    def tick
      @sell_in -= 1
      return if @quality.zero?

      @quality -= 1
      @quality -= 1 if @sell_in <= 0
    end
  end

  class Brie
    attr_reader :quality, :sell_in

    def initialize(sell_in, quality)
      @sell_in, @quality = sell_in, quality
    end

    def tick
      @sell_in -= 1
      return @quality = 50 if @quality == 49
      return if @quality >= 50

      @quality += 1
      @quality += 1 if @sell_in <= 0
    end
  end

  class Sulfuras
    attr_reader :quality, :sell_in

    def initialize(sell_in, quality)
      @sell_in, @quality = sell_in, quality
    end

    def tick
    end
  end

  class Backstage
    attr_reader :quality, :sell_in

    def initialize(sell_in, quality)
      @sell_in, @quality = sell_in, quality
    end

    def tick
      @sell_in -= 1
      return if @quality >= 50
      return @quality = 0 if @sell_in.negative?

      @quality += 1
      @quality += 1 if @sell_in < 10
      @quality += 1 if @sell_in < 5
    end
  end

  def quality
    return @item.quality if @item
    @quality
  end

  def sell_in
    return @item.sell_in if @item
    @sell_in
  end
end

def update_quality(items)
  items.each(&:tick)
end
