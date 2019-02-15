class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            quality_down_by_1(item)
          end
        end
      else
        if item.quality < 50
          item.quality += 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality += 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality += 1
              end
            end
          end
        end
      end

      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in -= 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.name != "Sulfuras, Hand of Ragnaros"
              more_than_0?(item)
              quality_down_by_1(item)
            end
          else
            item.quality -= item.quality
          end
        else
          less_than_50?(item)
          quality_up_by_1(item)
        end
      end
    end
  end

  private
    def less_than_50?(item)
      item.quality < 50 ? true : false
    end

    def more_than_0?(item)
      item.quality > 0 ? true : false
    end

    def quality_down_by_1(item)
      item.quality-=1 
    end

    def quality_up_by_1(item)
      item.quality+=1
    end
    
    
      
end
