require 'rails_helper'

RSpec.describe Board, type: :model do
  describe 'self.create_new(id: SecureRandom.uuid, email:, name:, width:, height:, bombs:)' do
    context "when create_new is called" do
      it 'should instantiate a new object with all values saved successfully' do
        id = SecureRandom.uuid
        email = "email@example.com"
        name = 'name'
        width = 1
        height = 1
        bombs = 1

        board = described_class.create_new(id: id, email: email, name: name, width: width, height: height, bombs: bombs)
        expect(board.id).to eq(id)
        expect(board.email).to eq(email)
        expect(board.name).to eq(name)
        expect(board.width).to eq(width)
        expect(board.height).to eq(height)
        expect(board.bombs).to eq(bombs)

        expect { described_class.save!(board) }.to_not raise_error
      end
    end
  end

  describe '#.update_board_matrix(matrix)' do
    context "when updating the board matrix" do
      it 'should create a new board_matrix object' do
        board = build(:board)
        matrix = [["1"]]

        board.update_board_matrix(matrix)

        expect(board.matrix).to eq(matrix)
        expect { board.save! }.to_not raise_error
      end
    end
  end

  describe '#.self.get_boards(order_params:, page_request:)' do
    let(:order_params) { {} }
    let(:page_request) { { page: 1, page_size: 10 }}
    context "when there is no boards" do
      it 'should return pagy and empty array' do
        pagy, result = Board.get_boards(order_params: order_params, page_request: page_request)
        expect(pagy.class).to eq(Pagy)
        expect(result.size).to eq(0)
      end
    end

    context "when there are boards" do
      it 'should return pagy and the boards' do
        create_list(:board, 2)
        pagy, result = Board.get_boards(order_params: order_params, page_request: page_request)
        expect(pagy.class).to eq(Pagy)
        expect(result.size).to eq(2)
      end
    end
  end

  describe '#.get_recent_boards' do
    context "when there are no boards" do
      it 'should return an empty array' do
        result = Board.get_recent_boards
        expect(result.size).to eq(0)
      end
    end

    context "when there are boards" do
      it 'should return 10 recent boards' do
        create_list(:board, 11)
        result = Board.get_recent_boards
        expect(result.size).to eq(10)
        expect(result.first.created_at > result.second.created_at).to be_truthy
      end
    end
  end
end
