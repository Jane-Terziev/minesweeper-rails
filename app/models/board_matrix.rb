class BoardMatrix < ApplicationRecord
  self.primary_key = :board_id

  belongs_to :board
end
