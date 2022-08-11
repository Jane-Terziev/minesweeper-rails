require 'util/types'

class CreateBoardContract < Dry::Validation::Contract
  params do
    required(:name).value(:str?, :filled?)
    required(:email).value(Types::Email)
    required(:width).value(:integer)
    required(:height).value(:integer)
    required(:bombs).value(:integer)
  end

  rule(:width) do
    key('Width').failure("must be greater or equal to #{Board::WIDTH_MIN_SIZE}.") if value < Board::WIDTH_MIN_SIZE
    key('Width').failure("must be less or equal to #{ApplicationRecord::ACTIVERECORD_MAX_INTEGER}") if value > ApplicationRecord::ACTIVERECORD_MAX_INTEGER
  end

  rule(:height) do
    key('Height').failure("must be greater or equal to #{Board::HEIGHT_MIN_SIZE}.") if value < Board::HEIGHT_MIN_SIZE
    key('Height').failure("must be less or equal to #{ApplicationRecord::ACTIVERECORD_MAX_INTEGER}") if value > ApplicationRecord::ACTIVERECORD_MAX_INTEGER
  end

  rule(:bombs) do
    key('Bombs').failure("must be greater or equal to #{Board::BOMBS_MIN_SIZE}.") if value < Board::BOMBS_MIN_SIZE
    key('Bombs').failure("must be less or equal to #{ApplicationRecord::ACTIVERECORD_MAX_INTEGER}") if value > ApplicationRecord::ACTIVERECORD_MAX_INTEGER
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
