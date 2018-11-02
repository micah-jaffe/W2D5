require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if self.include?(key)
      bucket(key).update(key, val)
    else
      resize! if @count == num_buckets
      bucket(key).append(key, val) 
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
  end

  def each
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

  def num_buckets
    @store.length
  end

  def resize!
    new_set = self.class.new(num_buckets * 2)
    
    @store.each do |bucket| 
      bucket.each do |el|
        new_set.insert(el)
      end 
    end 
    
    @store = new_set.store
    @count = new_set.count
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
















###################################
class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self.include?(num)
      if @count == num_buckets
        resize!
      end
      self[num] << num 
      @count += 1
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      @count -= 1
    end 
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_set = self.class.new(num_buckets * 2)
    
    @store.each do |bucket| 
      bucket.each do |el|
        new_set.insert(el)
      end 
    end 
    
    @store = new_set.store
    @count = new_set.count
  end
  
end
