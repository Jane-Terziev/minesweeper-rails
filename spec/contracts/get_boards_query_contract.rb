require 'rails_helper'

RSpec.describe GetBoardsQueryContract, type: :unit do
  let(:params) do
    {
        sort: "name",
        direction: "asc"
    }
  end
  subject(:contract) { described_class.new }

  describe "when the contract is called with parameters" do
    context "and the sort is not valid" do
      it 'should not be successful' do
        params[:sort] = 'invalid_sort'
        expect(contract.call(params).success?).to be_falsey
      end
    end

    context "and the direction is not valid" do
      it 'should not be successful' do
        params[:direction] = 'invalid_direction'
        expect(contract.call(params).success?).to be_falsey
      end
    end

    context "and the sort is missing" do
      it 'should be successful' do
        expect(contract.call(params.except(:sort)).success?).to be_truthy
      end
    end

    context "and the direction is missing" do
      it 'should be successful' do
        expect(contract.call(params.except(:direction)).success?).to be_truthy
      end
    end

    context "and all params are valid" do
      it 'should be successful' do
        expect(contract.call(params).success?).to be_truthy
      end
    end
  end
end
