require 'test_helper'

class BucketTest < Test::Unit::TestCase
  def test_empty_bucket
    bucket = Repaginator::Bucket.new
    
    assert bucket.empty?
    assert_equal 0, bucket.length
    assert_equal 0, bucket.size
  end
  
  def test_large_bucket_chain
    bucket = Repaginator::Bucket.new
    
    100_000.times do |n|
      bucket.append([ n, rand(100), n % 5, rand(1) ])
    end
    
    assert_equal 100_000, bucket.length
    assert_equal 100_000, bucket.size
    
    bucket.per_page = 100
    
    assert_equal (0..99).collect, bucket.page(1).collect { |r| r[0] }
    assert_equal (99900..99999).collect, bucket.page(1000).collect { |r| r[0] }
    
    filtered = bucket.exclude(2, [ 0 ])
    
    assert_equal 80_000, filtered.length
    
    assert_equal (0..124).reject { |n| n % 5 == 0 }, filtered.page(1).collect { |r| r[0] }
    
    bucket.delete(1)
    
    assert_equal 99_999, bucket.length
    assert_equal 79_999, filtered.length
    
    bucket.delete(0)
    
    # Item ID #0 is excluded by filter
    assert_equal 99_998, bucket.length
    assert_equal 79_999, filtered.length
    
    # Add item excluded by filter
    bucket.append([ 100_000, 42, 0, 1 ])
    
    assert_equal 99_999, bucket.length
    assert_equal 79_999, filtered.length
    
    # Add item not exculuded by filter
    bucket.append([ 100_001, 43, 1, 0 ])
    
    assert_equal 100_000, bucket.length
    assert_equal 80_000, filtered.length
  end
end
