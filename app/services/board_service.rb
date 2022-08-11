class BoardService
  attr_reader :board_repository

  def initialize(board_repository: Board)
    self.board_repository = board_repository
  end

  def create_board(params)
    board = ActiveRecord::Base.transaction do
      self.board_repository.create_new(**params).tap {|it| self.board_repository.save!(it) }
    end
    BoardGeneratingJob.perform_later(board)
    board
  end

  def update_board_matrix(board_id, board_matrix)
    board = ActiveRecord::Base.transaction do
      self.board_repository.get_by_id(board_id)
          .tap { |it| it.update_board_matrix(board_matrix) }
          .tap { |it| self.board_repository.save!(it) }
    end

    Turbo::StreamsChannel.broadcast_replace_to "grid_#{board_id}",
                                               target: "grid_#{board_id}",
                                               partial: 'boards/grid',
                                               locals: { board: board }
  end

  private

  attr_writer :board_repository
end
