class Board < ApplicationRecord
  has_one :board_matrix, foreign_key: :board_id, primary_key: :id

  def self.get_boards(order_params:, page_request:)
    paginate(
        collection: order(order_params),
        page_request: page_request
    )
  end

  def self.get_recent_boards
    order(created_at: 'desc').limit(10)
  end

  def self.create_new(id: SecureRandom.uuid, email:, name:, width:, height:, bombs:)
    new(id: id, email: email, name: name, width: width, height: height, bombs: bombs)
  end

  def update_board_matrix(board_matrix)
    self.build_board_matrix(matrix: board_matrix)
    self
  end

  def matrix
    self.board_matrix&.matrix
  end
end
