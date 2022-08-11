require 'rails_helper'

RSpec.describe BoardService, type: :unit do
  subject(:service) { described_class.new(board_repository: board_repository) }
  let(:board_repository) { spy(Board.name) }
  let(:board) { Board.new(id: SecureRandom.uuid) }

  describe '#.create_board(params)' do
    let(:params) do
      {
          name: 'name',
          email: 'example@example.com',
          width: 1,
          height: 1,
          bombs: 1
      }
    end

    context "when called with the exact parameters" do
      before do
        allow(board_repository).to receive(:create_new) { board }
        allow(board_repository).to receive(:save!)
      end

      it 'should create a new board and save' do
        expect { service.create_board(params) }.to_not raise_error
        expect(board_repository).to have_received(:create_new).with(**params)
        expect(board_repository).to have_received(:save!).with(board)
      end
    end
  end

  describe '#.update_board_matrix(board_id, matrix)' do
    let(:board) { instance_double("Board") }
    let(:board_id) { SecureRandom.uuid }
    let(:matrix) { [[]] }

    context "when a board with that id does not exist" do
      before do
        allow(board_repository).to receive(:get_by_id) { raise ActiveRecord::RecordNotFound }
      end

      it 'should raise not found error' do
        expect { service.update_board_matrix(board_id, matrix) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when the board is found" do
      before do
        allow(board_repository).to receive(:get_by_id) { board }
        allow(board).to receive(:update_board_matrix) { board }
        allow(board_repository).to receive(:save!) { board }
        allow(Turbo::StreamsChannel).to receive(:broadcast_replace_to)
      end

      it 'should update the board matrix and broadcast turbo' do
        expect { service.update_board_matrix(board_id, matrix) }.to_not raise_error
        expect(board_repository).to have_received(:get_by_id).with(board_id)
        expect(board).to have_received(:update_board_matrix).with(matrix)
        expect(board_repository).to have_received(:save!).with(board)
        expect(Turbo::StreamsChannel).to have_received(:broadcast_replace_to).with(
            "grid_#{board_id}", target: "grid_#{board_id}", partial: 'boards/grid', locals: { board: board }
        )
      end
    end
  end
end
