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
    if @map[key]
      update_node!(@map[key])
    else
      eject! if count == max
      cache_key!(key)
    end

    @map[key].val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private
  attr_reader :map, :store, :max, :prc

  def calc!(key)
    prc.call(key)
  end

  def update_node!(node)
    @map.delete(node.key)
    @store.remove(node.key)
    @store.append(node.key, node.val)
    @map[node.key] = @store.last
  end

  def cache_key!(key)
    @store.append(key, calc!(key))
    @map[key] = store.last
  end

  def eject!
    oldest_node = store.first
    @map.delete(oldest_node.key)
    @store.remove(oldest_node.key)
  end
end
