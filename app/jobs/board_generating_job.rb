require 'util/board_generator'

class BoardGeneratingJob < ApplicationJob
  def perform(board)
    sleep(5) # To demonstrate web socket notification after generating board
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