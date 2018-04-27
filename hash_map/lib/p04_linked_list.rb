require 'byebug'
include Enumerable
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = find_node(key)
    node.nil? ? nil : node.val
  end

  def find_node(key)
    found = false
    start = first
    until found
      break if start == @tail
      if start.key == key
        return start
      else
        start = start.next
      end
    end
    nil
  end


  def include?(key)
    !find_node(key).nil?
  end

  def append(key, val)
    node = Node.new(key, val)
    node.next, node.prev, = @tail, @tail.prev
    @tail.prev.next = node
    @tail.prev = node
  end

  def update(key, val)
    node = find_node(key)
    node.nil? ? nil : node.val = val
  end

  def remove(key)
    node = find_node(key)
    node.prev.next = node.next
    node.next.prev = node.prev
  end

  def each(&prc)
    start = first
    each_arr = []
    while true
      return each_arr if start == @tail
      each_arr << prc.call(start)
      start = start.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
