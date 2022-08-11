require 'util/types'

class GetBoardsQueryContract < Dry::Validation::Contract
  VALID_SORT_COLUMNS = Types::String.enum('name', 'email', 'width', 'height', 'bombs', 'created_at')
  SORT_DIRECTION = Types::String.enum('asc', 'desc')

  params do
    optional(:sort).maybe(VALID_SORT_COLUMNS)
    optional(:direction).maybe(SORT_DIRECTION)
  end

  def validated_classes
    [Board.to_s]
  end
end
