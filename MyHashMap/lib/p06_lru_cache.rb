require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    node = @map[key]
    
    if @store.include?(key)
      update_node!(node)
      node.val
    elsif count < @max
      reroute(key, calc!(key))
      @store.last.val
    else
      eject!
      reroute(key, calc!(key))
      @store.last.val
    end 
    
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    @prc.call(key)
  end
  
  def reroute(key, val)
    @store.append(key, val)
    new_node = @store.last
    @map[key] = new_node
  end
  
  def update_node!(node)
    @map.delete(node.key)
    @store.remove(node.key)
    reroute(node.key, node.val)
  end

  def eject!
    @store.remove(@store.first.key)
  end
end
