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