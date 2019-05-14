require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do

    # Sell in date has passed quality stays 0
    it 'check quality stays 0' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    # Sell in date has passed quality stays 0
    it 'check quality is not negative' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).not_to eq -1
    end

    # Quality remains 80
    it 'check Sulfuras, Hand of Ragnaros' do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 80
    end

    # Quality remains 80
    it 'check Sulfuras, Hand of Ragnaros if sell in date has passed' do
      items = [Item.new('Sulfuras, Hand of Ragnaros', -1, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 80
    end

    # Quality increases for aged brie
    it 'check Aged Brie if sell in date has not passed' do
      items = [Item.new('Aged Brie', 1, 39)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 40
    end

    # Quality increases for aged brie after date has passed 
    it 'check Aged Brie if sell in date has passed' do
      items = [Item.new('Aged Brie', -1, 49)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    # Quality stays 50 for aged brie after date has passed
    it 'check Aged Brie if sell in date has passed and quality is 50' do
      items = [Item.new('Aged Brie', -1, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    # Quality increases for Backstage passes
    it 'check Backstage passes to a TAFKAL80ETC concert for normal date' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 20, 19)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 20
    end

    # Quality increases twice for Backstage passes if sell in is less than 10 
    it 'check Backstage passes to a TAFKAL80ETC concert for less than 10 days' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 19)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 21
    end

    # Quality increases 3 times for Backstage passes if sell in is less than 5
    it 'check Backstage passes to a TAFKAL80ETC concert for less than 5 days' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 23
    end

    # Quality drops to 0 for Backstage passes if sell in date is passed
    it 'check Backstage passes to a TAFKAL80ETC concert after sell in date passed' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', -1, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    # Quality decrese twice for Conjured items within sell in date
    it 'check Conjured items' do
      items = [Item.new('Conjured Mana Cake', 2, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 18
    end

    # Quality decrese twice for Conjured items if date is passed
    it 'check Conjured items' do
      items = [Item.new('Conjured Mana Cake', 0, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 16
    end
  end
end
