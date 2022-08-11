class BoardGenerator
  attr_reader :width, :height, :bombs, :board

  def initialize(width:, height:, bombs:)
    self.width = width
    self.height = height
    self.bombs = bombs
  end

  def call
    self.board = Array.new(self.width) { Array.new(self.height, 0) }
    map_bomb_positions
    self
  end

  def map_bomb_positions
    mapped_number_of_bombs = 0
    while mapped_number_of_bombs < self.bombs
      x, y = generate_random_coordinates
      next if self.board[x][y] == 1

      self.board[x][y] = 1
      mapped_number_of_bombs += 1
    end
  end

  def generate_random_coordinates
    [rand(0..self.width - 1), rand(0..self.height - 1)]
  end

  attr_writer :width, :height, :bombs, :board
end
