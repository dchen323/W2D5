require 'byebug'
class MaxIntSet
  def initialize(max)
    @store = Array.new(max){false}
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    # debugger
    @store[num]
  end

  private

  def is_valid?(num)
    num < @store.length && num > 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    # debugger
    # raise "Error" if num > num_buckets
    @store[self[num]] << num
  end

  def remove(num)
    @store[self[num]].each do |bucket_el|
      @store[self[num]] -= [bucket_el] if bucket_el == num
    end
  end

  def include?(num)
    # debugger
    @store[self[num]].each do |bucket|
      return true if bucket == num
    end
    false
  end

  private

  def [](num)
    num % num_buckets
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize!  if @count == num_buckets
    unless include?(num)
      @store[self[num]] << num
      @count +=1
    end
  end

  def remove(num)
    @store[self[num]].each do |bucket_el|
      if bucket_el == num
        @store[self[num]] -= [bucket_el]
        @count -=1
      end
    end
  end

  def include?(num)
    @store[self[num]].each do |bucket|
      return true if bucket == num
    end
    false
  end


  private

  def [](num)
    num % num_buckets
  end


  def num_buckets
    @store.length
  end

  def resize!
    temp_store = Array.new(num_buckets * 2) { Array.new }
    new_buckets = num_buckets * 2
    @store.each do |bucket|
      bucket.each do |el|
        temp_store[el % new_buckets].push(el)
      end
    end
      @store = temp_store
  end

end
