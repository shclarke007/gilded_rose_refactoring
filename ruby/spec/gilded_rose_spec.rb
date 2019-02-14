require 'gilded_rose'
require 'item'

describe GildedRose do
  
  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end 
    context "#quality" do
      items = [Item.new('Aged Brie', 2, 50), 
        Item.new('Elixir of the Mongoose', 2, 0)]
      rose = GildedRose.new(items)
      it 'never more than 50' do
        expect { rose.update_quality }.to change { items[0].quality }.by(0)
      end 
      it 'quality is never negative' do
        expect { rose.update_quality }.to change { items[1].quality }.by(0)
      end 
    end
    
    context "Not Aged Brie, Backstage passes or Sulfuras, Hand of Ragnaros" do
      it 'quality decreases when sell_in has passed' do
        items = [Item.new('+5 Dexterity Vest', 10, 20), 
          Item.new('Elixir of the Mongoose', 5, 7)]
        rose = GildedRose.new(items)
        expect { rose.update_quality }.to change { items[0].quality }.by(-1)
        expect { rose.update_quality }.to change { items[0].sell_in }.by(-1)
      end
    end 

    context "Aged Brie" do
      it 'quality increases when sell_in approaches' do
        items = [Item.new('Aged Brie', 2, 0)]
        rose = GildedRose.new(items)
        expect { rose.update_quality }.to change { items[0].quality }.by(1)
      end
      it 'quality increases by 2 after sell_in date' do
        items = [Item.new('Aged Brie', -2, 0),
                Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20)]
        rose = GildedRose.new(items)
        expect { rose.update_quality }.to change { items[0].quality }.by(2)
      end
    end
    describe "Backstage passes" do
      context "sell_in approaches" do
        it 'quality increases by 1' do
          items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20)]
          rose = GildedRose.new(items)
          expect { rose.update_quality }.to change { items[0].quality }.by(1)
        end
      end
      context "sell_in 10 or less days" do
        it 'quality increases by 2' do
          items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 20)]
          rose = GildedRose.new(items)
          expect { rose.update_quality }.to change { items[0].quality }.by(2)
        end
      end   
      context "sell_in 5 or less days" do
        it 'quality increases by 3' do
          items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 20)]
          rose = GildedRose.new(items)
          expect { rose.update_quality }.to change { items[0].quality }.by(3)
        end
      end  
      context "concert passes" do
        it 'quality drops to 0' do
          items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 20)]
          rose = GildedRose.new(items)
          expect { rose.update_quality }.to change { items[0].quality }.to(0)
        end
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
