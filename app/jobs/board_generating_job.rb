require 'util/board_generator'

class BoardGeneratingJob < ApplicationJob
  def perform(board)
    sleep(5)
    BoardService.new.update_board_matrix(
        board.id,
        BoardGenerator.new(
            width: board.width,
            height: board.height,
            bombs: board.bombs
        ).call.board
    )
  end
end