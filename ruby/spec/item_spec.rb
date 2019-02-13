require './lib/item'

describe Item do
  let(:item) { Item.new('Aged Brie', 2, 0) }
  it 'knows the name of an item' do
    expect(item.name).to eq ('Aged Brie')  
  end
  it 'knows the sell_in of an item' do
    expect(item.sell_in).to eq (2)  
  end
  it 'knows the quality of an item' do
    expect(item.quality).to eq (0)  
  end

  it 'returns a string about item' do
    expect(item.to_s).to eq('Aged Brie, 2, 0')  
  end
end
