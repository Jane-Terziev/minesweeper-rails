require 'util/types'

class CreateBoardContract < Dry::Validation::Contract
  params do
    required(:name).value(:str?, :filled?)
    required(:email).value(Types::Email)
    required(:width).value(:integer, min_size?: 2, max_size?: ApplicationRecord::ACTIVERECORD_MAX_INTEGER)
    required(:height).value(:integer, min_size?: 2, max_size?: ApplicationRecord::ACTIVERECORD_MAX_INTEGER)
    required(:bombs).value(:integer, min_size?: 1, max_size?: ApplicationRecord::ACTIVERECORD_MAX_INTEGER)
  end

  rule(:width, :height, :bombs) do
    if values[:bombs] >= (values[:width] * values[:height])
      key('Number of bombs').failure("cannot be bigger or equal to the board size.")
    end
  end

  def validated_classes
    [Board.to_s]
  end
end
