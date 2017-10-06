class PolyTreeNode
  attr_accessor :value, :parent, :children

  def initialize(value, parent = nil, children = [])
    @value, @parent, @children = value, parent, children
  end

  def parent=(par)
    @parent.children.delete(self) if @parent
    @parent = par
    if par
      par.children << self unless par.children.include?(self)
    end
  end

  def add_child(child)
    @children << child
    child.parent = self
  end

  def remove_child(child)
    raise "Not a child" unless @children.include?(child)
    @children.delete(child)
    child.parent = nil
  end


  def dfs(target_value)
    return self if self.value == target_value
    @children.each do |c|
      result = c.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
       current_node = queue.shift
       return current_node if target_value == current_node.value
       queue += current_node.children
     end

     return nil

  end

end
