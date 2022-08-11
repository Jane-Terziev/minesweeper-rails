require 'rails_helper'

RSpec.describe BoardGenerator, type: :unit do
  describe "#.call" do
    context "when the board generator is called" do
      it 'should generate a board with width, height and bombs' do
        generator = described_class.new(width: 2, height: 2, bombs: 2)
        expect { generator.call }.to_not raise_error
        expect(generator.board.flatten.count(1)).to eq(2)
      end
    end
  end
end