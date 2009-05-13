require 'test_helper'

class SetTest < Test::Unit::TestCase
  def test_empty_set
    set = Repaginator::Set.new
    
    assert set.empty?
    assert_equal 0, set.length
    assert_equal 0, set.size
  end
  
  def test_create_set
    sample_list = %w[ a b c d e f g h i j ].freeze
    
    set = Repaginator::Set.new(sample_list)
    
    assert_equal sample_list.length, set.length
    
    sample_list.each do |item|
      assert set.include?(item)
    end
  end
end
