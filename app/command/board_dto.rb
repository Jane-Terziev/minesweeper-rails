require 'util/application_read_struct'
require 'util/types'

class BoardDto < ApplicationReadStruct
  attribute :id, Types::UUID
  attribute :name, Types::String
  attribute :email, Types::Email
  attribute :width, Types::Integer
  attribute :height, Types::Integer
  attribute :bombs, Types::Integer
  attribute :created_at, Types::DateTime
  attribute :updated_at, Types::DateTime
  attribute? :board_matrix, BoardMatrixDto

  def matrix
    board_matrix&.matrix
  end
end