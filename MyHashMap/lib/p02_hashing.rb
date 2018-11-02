class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_value = nil.hash
    self.each_with_index do |el, i|
      if el.is_a?(Array) 
        hash_value = el.hash 
      else
        hash_value ^= i.hash * el.hash
      end
    end 
    
    hash_value 
  end
  
end

class String
  def hash
    self.bytes.hash
  end
end


class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = self.to_a
    arr.sort_by! {|x| x.first}
    arr.hash 
  end

end
