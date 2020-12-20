shared_examples_for "Payment::LoyaltyPoints" do
  describe 'by_loyalty_points' do
    let(:loyalty_points_payment_method) { Spree::PaymentMethod::LoyaltyPoints.create!(active: true, name: 'LoyaltyPoints') }
    let(:check_payment_method) { Spree::PaymentMethod::Check.create!(active: true, name: 'Check') }
    let(:payment1) { create(:payment_with_loyalty_points, amount: 10, payment_method: loyalty_points_payment_method) }
    let(:payment2) { create(:payment_with_loyalty_points, amount: 10, payment_method: check_payment_method) }

    it "returns payments with loyalty_points payment method" do
      expect(Spree::Payment.by_loyalty_points).to eq([payment1])
    end
  end

  describe 'any_with_loyalty_points?' do
    let(:payments) { create_list(:payment_with_loyalty_points, 5, state: "completed") }

    context "when payment made using loyalty points" do
      before do
        allow(Spree::Payment).to receive(:by_loyalty_points).and_return(payments)
      end

      it "returns true" do
        expect(Spree::Payment.any_with_loyalty_points?).to eq(true)
      end
    end

    context "when payment not made using loyalty points" do
      before do
        allow(Spree::Payment).to receive(:by_loyalty_points).and_return([])
      end

      it "returns false" do
        expect(Spree::Payment.any_with_loyalty_points?).to eq(false)
      end
    end
  end

  describe 'redeem_loyalty_points' do
    before do
      allow(resource_instance).to receive(:by_loyalty_points?).and_return(true)
      allow(resource_instance).to receive(:loyalty_points_for).and_return(55)
    end

    it "receives create_debit_transaction on order" do
      expect(resource_instance.order).to receive(:create_debit_transaction)
      resource_instance.send(:redeem_loyalty_points)
    end

    it "creates loyalty_points_debit_transaction on order" do
      resource_instance.send(:redeem_loyalty_points)
      expect(Spree::LoyaltyPointsDebitTransaction.last.loyalty_points).to eq(55)
    end
  end

  describe 'return_loyalty_points' do
    before do
      allow(resource_instance).to receive(:loyalty_points_for).and_return(30)
      order = create(:order_with_loyalty_points)
      resource_instance.order = order
      @loyalty_points_redeemed = resource_instance.loyalty_points_for(resource_instance.amount, 'redeem')
    end

    it "receives create_credit_transaction on order" do
      expect(resource_instance.order).to receive(:create_credit_transaction).with(@loyalty_points_redeemed)
      resource_instance.send(:return_loyalty_points)
    end

    it "creates loyalty_points_credit_transaction on order" do
      resource_instance.send(:return_loyalty_points)
      expect(Spree::LoyaltyPointsCreditTransaction.last.loyalty_points).to eq(30)
    end
  end

  describe 'by_loyalty_points?' do
    let(:loyalty_points_payment_method) { Spree::PaymentMethod::LoyaltyPoints.create!(active: true, name: 'LoyaltyPoints') }
    let(:check_payment_method) { Spree::PaymentMethod::Check.create!(active: true, name: 'Check') }

    context "when payment_method type is LoyaltyPoints" do
      before do
        resource_instance.payment_method = loyalty_points_payment_method
      end

      it "returns true" do
        expect(resource_instance.send(:by_loyalty_points?)).to be_truthy
      end
    end

    context "when payment_method type is not LoyaltyPoints" do
      before do
        resource_instance.payment_method = check_payment_method
      end

      it "returns false" do
        expect(resource_instance.send(:by_loyalty_points?)).to be_falsey
      end
    end
  end

  describe 'redeemable_loyalty_points_balance?' do
    before do
      allow(SpreeLoyaltyPoints::Config).to receive(:loyalty_points_redeeming_balance).and_return(30)
    end

    context "when amount greater than redeeming balance" do
      before do
        resource_instance.order.user.loyalty_points_balance = 40
      end

      it "returns true" do
        expect(resource_instance.send(:redeemable_loyalty_points_balance?)).to be_truthy
      end
    end

    context "when amount less than redeeming balance" do
      before do
        resource_instance.order.user.loyalty_points_balance = 20
      end

      it "returns false" do
        expect(resource_instance.send(:redeemable_loyalty_points_balance?)).to be_falsey
      end
    end

    context "when amount equal to redeeming balance" do
      before do
        resource_instance.order.user.loyalty_points_balance = 30
      end

      it "returns false" do
        expect(resource_instance.send(:redeemable_loyalty_points_balance?)).to be_truthy
      end
    end
  end

  describe 'redeemable_user_balance' do
    context "when Loyalty Points are redeemable" do
      before do
        allow(resource_instance).to receive(:redeemable_loyalty_points_balance?).and_return(true)
      end

      it "does not add errors to loyalty_points_balance" do
        resource_instance.send(:redeemable_user_balance)
        expect(resource_instance.errors[:loyalty_points_balance]).to be_empty
      end
    end

    context "when Loyalty Points are not redeemable" do
      before do
        allow(resource_instance).to receive(:redeemable_loyalty_points_balance?).and_return(false)
        allow(SpreeLoyaltyPoints::Config).to receive(:loyalty_points_redeeming_balance).and_return(30)
        allow(resource_instance.order.user).to receive(:loyalty_points_balance).and_return(20)
      end

      it "adds error to loyalty_points_balance" do
        min_balance = SpreeLoyaltyPoints::Config.loyalty_points_redeeming_balance
        resource_instance.send(:redeemable_user_balance)
        expect(resource_instance.errors[:loyalty_points_balance]).to eq(["should be atleast #{min_balance.to_s + ' ' + 'point'.pluralize(min_balance)} for redeeming Loyalty Points"])
      end
    end
  end
end
