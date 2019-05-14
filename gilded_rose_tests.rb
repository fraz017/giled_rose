require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

class TestUntitled < Test::Unit::TestCase
  def test_foo
    items = [Item.new('foo', 0, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].name, 'foo'
  end

  def test_foo_quality
    items = [Item.new('foo', 0, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 0
  end

  def test_foo_quality_sell_in_passed
    items = [Item.new('foo', -1, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 0
  end

  def test_sulfuras
    items = [Item.new('Sulfuras, Hand of Ragnaros', -1, 80)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 80
  end

  def test_aged_brie
    items = [Item.new('Aged Brie', -1, 49)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 50
  end

  def test_backstage
    items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 40)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 41
  end

  def test_backstage_less_than_10
    items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 40)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 42
  end

  def test_backstage_less_than_5
    items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 40)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 43
  end

  def test_backstage_after_sellin_date
    items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 40)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 0
  end

  def test_conjured
    items = [Item.new('Conjured', 3, 40)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 38
  end

  def test_conjured_after_sellin_passed
    items = [Item.new('Conjured', 0, 40)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 36
  end
end
