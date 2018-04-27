class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    map.with_index {|el,idx| el.to_s.ord**idx}.inject(:+).hash
  end
end

class String
  def hash
    chars.map.with_index {|el,idx| el.ord*idx}.inject(:+).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = 0
    each {|k,v| sum+= k.to_s.ord * v.to_s.ord}
    sum.hash
  end
end
