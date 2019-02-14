require 'gilded_rose'
require 'item'

describe GildedRose do
  
  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end 

    context "Not Aged Brie, Backstage passes or Sulfuras, Hand of Ragnaros" do
      it 'quality decreases when sell_in has passed' do
        items = [Item.new('+5 Dexterity Vest', 10, 20)]
        rose = GildedRose.new(items)
        expect { rose.update_quality }.to change { items[0].quality }.by(-1)
        expect { rose.update_quality }.to change { items[0].sell_in }.by(-1)
      end
    end 

    context "Aged Brie & Backstage passes to a TAFKAL80ETC concert" do
      it 'quality increases when sell_in approaches' do
        items = [Item.new('Aged Brie', 2, 0),
                Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20)]
        rose = GildedRose.new(items)
        expect { rose.update_quality }.to change { items[0].quality }.by(1)
        expect { rose.update_quality }.to change { items[1].quality }.by(1)
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 80)]
      rose = GildedRose.new(items)
      it 'quality never decreses' do
        expect { rose.update_quality }.to change { items[0].quality }.by(0)
      end
      it 'never has to be sold' do
        expect { rose.update_quality }.to change { items[0].sell_in }.by(0)
      end    
    end
    

    end 
end
