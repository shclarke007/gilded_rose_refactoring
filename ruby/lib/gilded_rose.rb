class GildedRose
  MAX_QUALITY = 50
  MIN_QUALITY = 0
  MID_QUALITY = 11
  LOW_QUALITY = 6
    
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.sell_in -= 1 unless sulfuras?(item)
      
      quality_up_by_1(item) unless !sell_in_10(item) && quality_less_than_50?(item) if backstage?(item)
      quality_up_by_1(item) unless !sell_in_5(item) && quality_less_than_50?(item) if backstage?(item)

      if normal_items?(item)
        quality_down_by_1(item)
      else 
        quality_up_by_1(item) if quality_less_than_50?(item) # quality is never more than 50
      end
    
      if expired(item)
        unless aged_brie?(item)
          quality_down_by_1(item) unless special_items?(item) && quality_more_than_0?(item)
          item.quality -= item.quality
        else
          quality_up_by_1(item) if quality_less_than_50?(item) # aged_brie increases 
        end
      end
    end
  end

  private
  def quality_less_than_50?(item)
    item.quality < MAX_QUALITY
  end

  def quality_more_than_0?(item)
    item.quality > MIN_QUALITY
  end

  def quality_down_by_1(item) 
    item.quality -= 1 if quality_more_than_0?(item) unless sulfuras?(item) 
  end

  def quality_up_by_1(item)
    item.quality += 1
  end

  def sell_in_10(item)
    item.sell_in < MID_QUALITY 
  end
    
  def sell_in_5(item)
    item.sell_in < LOW_QUALITY 
  end  

  def expired(item)
    item.sell_in < 0 
  end
  
  def normal_items?(item)
    !aged_brie?(item) && !backstage?(item) 
  end

  def special_items?(item)
    aged_brie?(item) || backstage?(item) || sulfuras?(item)
  end
  
  def aged_brie?(item)
    item.name == "Aged Brie"
  end
    
  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end
    
  def backstage?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end
     
end
