class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.sell_in -= 1 unless is_sulfuras?(item)

      if normal_item?(item)
        quality_down_by_1(item)
      else 
        quality_up_by_1(item) unless !quality_less_than_50?(item) 
      end

      if is_backstage?(item)
        quality_up_by_1(item) unless !sell_in_10(item) && quality_less_than_50?(item) 
        quality_up_by_1(item) unless !sell_in_5(item) && quality_less_than_50?(item) 
      end
    
      if item.sell_in < 0
        if !is_aged_brie?(item)
          if !is_backstage?(item)
            quality_down_by_1(item) unless is_sulfuras?(item) && quality_more_than_0?(item)
          else
            item.quality -= item.quality
          end
        else
          quality_up_by_1(item) unless !quality_less_than_50?(item) 
        end
      end
    end
  end

  private
    def quality_less_than_50?(item)
      item.quality < 50 ? true : false
    end

    def quality_more_than_0?(item)
      item.quality > 0 ? true : false
    end

    def quality_down_by_1(item) 
      if quality_more_than_0?(item)
        item.quality-=1 unless is_sulfuras?(item) 
      end
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

    def normal_item?(item)
      !is_aged_brie?(item) && !is_backstage?(item) ? true : false
    end

    def is_aged_brie?(item)
      item.name == "Aged Brie" ? true : false
    end
    
    def is_sulfuras?(item)
      item.name == "Sulfuras, Hand of Ragnaros" ? true : false
    end
    
    def is_backstage?(item)
      item.name == "Backstage passes to a TAFKAL80ETC concert" ? true : false
    end
     
end
