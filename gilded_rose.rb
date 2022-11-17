module Item
  class Base
    attr_reader :quality, :sell_in

    def initialize(sell_in, quality)
      @sell_in, @quality = sell_in, quality
    end

    def tick; end
  end

  class Normal < Base
    def tick
      @sell_in -= 1
      return if @quality.zero?

      @quality -= 1
      @quality -= 1 if @sell_in <= 0
    end
  end

  class Brie < Base
    def tick
      @sell_in -= 1
      return @quality = 50 if @quality == 49
      return if @quality >= 50

      @quality += 1
      @quality += 1 if @sell_in <= 0
    end
  end

  class Backstage < Base
    def tick
      @sell_in -= 1
      return if @quality >= 50
      return @quality = 0 if @sell_in.negative?

      @quality += 1
      @quality += 1 if @sell_in < 10
      @quality += 1 if @sell_in < 5
    end
  end

  DEFAULT_CLASS = Base
  SPECIALIZED_CLASSES = {
    'normal' => Normal,
    'Aged Brie' => Brie,
    'Backstage passes to a TAFKAL80ETC concert' => Backstage
  }

  def self.for(name, sell_in, quality)
    (SPECIALIZED_CLASSES[name] || DEFAULT_CLASS).new(sell_in, quality)
  end
end

def update_quality(items)
  items.each(&:tick)
end
