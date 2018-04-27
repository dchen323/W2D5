require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize!  if @count == num_buckets
    unless include?(key)
      @store[self[key]] << key
      @count +=1
    end
  end

  def include?(key)
    @store[self[key]].each do |bucket|
      return true if bucket == key
    end
    false
  end

  def remove(key)
    @store[self[key]].each do |bucket_el|
      if bucket_el == key
        @store[self[key]] -= [bucket_el]
        @count -=1
      end
    end
  end

  private

  def [](num)
    num.hash % num_buckets
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }
    old_store.each do |bucket|
      bucket.each do |el|
        insert(el)
      end
    end
      @store
  end
end
