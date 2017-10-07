require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board, @next_mover_mark, @prev_move_pos = board, next_mover_mark, prev_move_pos
  end

  def losing_node?(evaluator)
    if children.length == 0
      if @board.winner? == evaluator || nil
        return false
      else
        return true
      end
    end

    if @next_mover_mark == evaluator
      return children.all? { |c| losing_node?(c) }
    else
      return children.any? { |c| losing_node?(c) }
    end

  end

  # board = game.board.dup
  # pos = [row, col]
  #
  # next unless board.empty?(pos)
  # board[pos] = mark
  #
  # return pos if board.winner == mark

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.

  def get_empty_squares
    empty_squares = @board.rows.select do |row|
      row.select { |el| @board.empty? }
    end
    
  end

  def children

  end
end
