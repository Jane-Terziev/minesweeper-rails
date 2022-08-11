require 'rails_helper'

RSpec.describe CreateBoardContract, type: :unit do
  let(:params) do
    {
        email: "valid_email@example.com",
        name: "board_name",
        width: 3,
        height: 3,
        bombs: 3
    }
  end
  subject(:contract) { described_class.new }

  describe "when the contract is called with parameters" do
    context "and the email is in an invalid format" do
      it 'should not pass the validation' do
        params[:email] = "invalid_email_format"
        expect(contract.call(params).success?).to be_falsey
      end
    end

    context "and the email parameter is sent as empty string" do
      it 'should not pass the validation' do
        params[:email] = ""
        expect(contract.call(params).success?).to be_falsey
      end
    end

    context "and the email parameter is not sent" do
      it 'should not pass the validation' do
        expect(contract.call(params.except(:email)).success?).to be_falsey
      end
    end

    context "and the name parameter is sent as empty string" do
      it 'should not pass the validation' do
        params[:name] = ""
        expect(contract.call(params).success?).to be_falsey
      end
    end

    context "and the name parameter is not sent" do
      it 'should not pass the validation' do
        expect(contract.call(params.except!(:name)).success?).to be_falsey
      end
    end

    context "and the width parameter is less than 2" do
      it 'should not pass the validation' do
        params[:width] = 1
        expect(contract.call(params).success?).to be_falsey
      end
    end

    context "and the width parameter is not sent" do
      it 'should not pass the validation' do
        expect(contract.call(params.except!(:width)).success?).to be_falsey
      end
    end

    context "and the height parameter is less than 2" do
      it 'should not pass the validation' do
        params[:height] = 1
        expect(contract.call(params).success?).to be_falsey
      end
    end

    context "and the height parameter is not sent" do
      it 'should not pass the validation' do
        expect(contract.call(params.except!(:height)).success?).to be_falsey
      end
    end

    context "and the bombs parameter is equal than the board size" do
      it 'should not pass the validation' do
        params[:bombs] = params[:width] * params[:height]
        expect(contract.call(params).success?).to be_falsey
      end
    end

    context "and the bombs parameter is higher than the board size" do
      it 'should not pass the validation' do
        params[:bombs] = (params[:width] * params[:height]) + 1
        expect(contract.call(params).success?).to be_falsey
      end
    end

    context "and the bombs parameter is not sent" do
      it 'should not pass the validation' do
        expect(contract.call(params.except!(:bombs)).success?).to be_falsey
      end
    end

    context "and everything is valid" do
      it 'should pass the validation' do
        expect(contract.call(params).success?).to be_truthy
      end
    end
  end
end
