require "spec_helper"

describe Spree::LoyaltyPointsCreditTransaction do

  let(:loyalty_points_credit_transaction) { build(:loyalty_points_credit_transaction) }

  it "is valid with valid attributes" do
    expect(loyalty_points_credit_transaction).to be_valid
  end

  describe 'update_user_balance' do

    it "should increment user's energy_coins" do
      expect {
        loyalty_points_credit_transaction.send(:update_user_balance)
      }.to change{ loyalty_points_credit_transaction.user.energy_coins }.by(loyalty_points_credit_transaction.loyalty_points)
    end

  end

  describe 'update_balance' do
    let(:user_balance) { 300 }

    before :each do
      allow(loyalty_points_credit_transaction.user).to receive(:energy_coins).and_return(user_balance)
      loyalty_points_credit_transaction.send(:update_balance)
    end

    it "should set balance" do
      expect(loyalty_points_credit_transaction.balance).to eq(user_balance + loyalty_points_credit_transaction.loyalty_points)
    end

  end

end
