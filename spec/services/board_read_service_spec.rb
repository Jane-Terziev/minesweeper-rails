require 'rails_helper'

RSpec.describe BoardReadService, type: :unit do
  subject(:service) { described_class.new(board_repository: board_repository) }
  let(:board_repository) { spy('Board') }
  let(:order_params) { { created_at: 'asc' }}
  let(:page_request) { { page: 1, page_size: 10 } }

  describe '#.get_boards(order_params)' do
    context "when there are records found" do
      before do
        allow(board_repository).to receive(:get_boards) { [Pagy.new(count: 1), [Board.new]] }
      end
      it 'should return elements' do
        _, result = service.get_boards(order_params: order_params, page_request: page_request)
        expect(result.size).to eq(1)
      end
    end

    context "when records are not found" do
      before do
        allow(board_repository).to receive(:get_boards) { [] }
      end
      it 'should return empty array' do
        _, result = service.get_boards(order_params: order_params, page_request: page_request)
        expect(result.size).to eq(0)
      end
    end
  end

  describe "#.get_board_by_id(id:)" do
    let(:board) { Board.new(id: SecureRandom.uuid) }

    context "when board is not found" do
      before do
        allow(board_repository).to receive(:get_by_id) { raise ActiveRecord::RecordNotFound }
      end

      it 'should raise record not found error' do
        expect { service.get_board_by_id(id: 'invalid_id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when the board is found" do
      before do
        allow(board_repository).to receive(:get_by_id) { board }
      end

      it 'should return it' do
        expect { service.get_board_by_id(id: board.id) }.to_not raise_error
      end
    end
  end

  describe '#.get_recent_boards' do
    context "when there are no recent boards" do
      before do
        allow(board_repository).to receive(:get_recent_boards) { [] }
      end

      it 'should return an empty array' do
        result = service.get_recent_boards
        expect(result.size).to eq(0)
      end
    end

    context "when there are recent boards" do
      before do
        allow(board_repository).to receive(:get_recent_boards) { [Board.new] }
      end

      it 'should return the boards' do
        result = service.get_recent_boards
        expect(result.size).to eq(1)
      end
    end
  end
end
