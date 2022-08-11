class BoardReadService
  attr_reader :board_repository

  def initialize(board_repository: Board)
    self.board_repository = board_repository
  end

  def get_boards(order_params:, page_request:)
    pagy, collection = self.board_repository.get_boards(order_params: order_params, page_request: page_request)
    [pagy, collection.to_a.map{ |it| map_board_to_dto(it) }]
  end

  def get_recent_boards
    self.board_repository.get_recent_boards.to_a.map { |it| map_board_to_dto(it) }
  end

  def get_board_by_id(id:)
    map_board_to_dto(self.board_repository.get_by_id(id))
  end

  private

  def map_board_to_dto(board)
    BoardDto.new(
        id: board.id,
        name: board.name,
        email: board.email,
        width: board.width,
        height: board.height,
        bombs: board.bombs,
        board_matrix: BoardMatrixDto.new(
            matrix: board.matrix
        ),
        created_at: board.created_at,
        updated_at: board.updated_at
    )
  end

  attr_writer :board_repository
end
