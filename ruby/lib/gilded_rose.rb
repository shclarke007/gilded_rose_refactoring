class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if !is_aged_brie?(item) && !is_backstage?(item)
        if more_than_0?(item)
          quality_down_by_1(item) if !is_sulfas?(item) end
      else
        if less_than_50?(item)
          quality_up_by_1(item)
          if is_backstage?(item)
            quality_up_by_1(item) if sell_in_10(item) && less_than_50?(item)
              less_than_50?(item) && quality_up_by_1(item) if sell_in_5(item) end
            end
          end
      item.sell_in -= 1 if !is_sulfas?(item)  
      if item.sell_in < 0
        if !is_aged_brie?(item)
          if !is_backstage?(item)
            quality_down_by_1(item) if !is_sulfas?(item) && more_than_0?(item)
          else
            item.quality -= item.quality
          end
        else
          quality_up_by_1(item) if less_than_50?(item) 
        end
      end
    end
  end

  private
    def less_than_50?(item)
      item.quality < 50 ? true : false
    end

    def more_than_0(item)
      item.quality > 0 ? true : false
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

    def sell_in_10(item)
      item.sell_in < 11 ? true : false 
    end
    
    def sell_in_5(item)
      item.sell_in < 6 ? true : false 
    end  
    
    def is_sulfas?(item)
      item.name == "Sulfuras, Hand of Ragnaros" ? true : false
    end
    
    def is_backstage?(item)
      item.name == "Backstage passes to a TAFKAL80ETC concert" ? true : false
    end
  
    def is_aged_brie?(item)
      item.name == "Aged Brie" ? true : false
    end
    
end
