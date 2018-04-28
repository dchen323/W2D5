require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  # include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    node = @store[bucket(key)].find_node(key)
    node.nil? ? false : true
  end

  def set(key, val)
    resize!  if @count == num_buckets
    # debugger
    if include?(key)
      @store[bucket(key)].update(key, val)
    else
      @store[bucket(key)].append(key, val)
      @count +=1
    end
  end

  def get(key)
    node = @store[bucket(key)].find_node(key)
    node.nil? ? nil : node.val
  end

  def delete(key)
    node = @store[bucket(key)].remove(key)
    if node
      @count -= 1
    else
      return nil
    end
  end

  def each(&prc)
     ans = []
     @store.each do |linked_list|
       linked_list.each do |node|

         ans += prc.call(node.key, node.val)
       end
     end
     ans
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private
  # include Enumerable

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }
    old_store.each do |linked_list|
      linked_list.
    end
      @store
  end

  def bucket(key)
    key.hash % num_buckets
    # optional but useful; return the bucket corresponding to `key`
  end
end
