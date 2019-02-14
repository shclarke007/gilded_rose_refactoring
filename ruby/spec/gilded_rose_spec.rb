require 'gilded_rose'

describe GildedRose do
  
  describe "#update_quality" do
    # let(:item) { Item.new() }
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end 
    context "item is not Aged Brie, Backstage passes or Sulfuras" do
      it 'quality decreases when sell in has passed' do
        items = [Item.new('+5 Dexterity Vest', 10, 20)]
        rose = GildedRose.new(items)
        expect { rose.update_quality }.to change { items[0].quality }.by(-1)
        expect { rose.update_quality }.to change { items[0].sell_in }.by(-1)
      end
    end  
    context "Aged Brie" do
      it 'quality increases the older it gets' do
        items = [Item.new('Aged Brie', 2, 0)]
        rose = GildedRose.new(items)
        expect { rose.update_quality }.to change { items[0].quality }.by(1)
      end
    end
    end
    
    
  
end
