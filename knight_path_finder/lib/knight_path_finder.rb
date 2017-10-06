require 'set'
require_relative '00_tree_node'

class KnightPathFinder

  def initialize(pos)
    @start_node = PolyTreeNode.new(pos)
  end

  def self.valid_moves(pos)
    board_r = (0...8)
    valid_moves = []
    moves = [[-2, 1],[2,1],[-2,-1],[2,-1]]
    moves += moves.map{|e| e.reverse}
    moves.each do |m|
      x = pos[0]+m[0]
      y = pos[1]+m[1]
      valid_moves << [x, y] if board_r.cover?(x) && board_r.cover?(y)
    end
    valid_moves
  end

  def new_moves_nodes(p_node)
    positions = KnightPathFinder.valid_moves(p_node.value).reject do
      |node| @visited_positions.include?(node)
    end

    return [] if positions.empty?

    nodes = positions.map do |pos|
      PolyTreeNode.new(pos)
    end

    nodes.each do |node|
      node.parent = p_node
      p_node.add_child(node)
      @visited_positions << node.value
    end

    return nodes
  end


  def build_move_tree(node)
    queue = [node]
    @visited_positions = [node].to_set
    while queue.length > 0
      new_node = queue.shift
      queue += new_moves_nodes(new_node)
    end
    return node
  end

  def find_path(end_pos)

    tree = build_move_tree(@start_node)

    end_node = tree.dfs(end_pos)


    return trace_path_back(end_node).reverse
  end

  def trace_path_back(node)
    result = []
    until node == nil
      puts node
      result.push(node.value) if node
      node = node.parent
    end

    return result
  end

  def display_path(path)
    n = 0
    (0...8).each do |i|
      (0...8).each do |j|
        if path[0] == [i,j]
          print '|S'
        elsif path[-1] == [i,j]
          print '|E'
        elsif path.include?([i,j])
          n+= 1
          print "|#{n}"
        else
          print '| '
        end
      end
      puts '|'
    end
  end

end
