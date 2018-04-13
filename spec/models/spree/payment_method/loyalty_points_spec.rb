require 'spec_helper'

describe Spree::PaymentMethod::LoyaltyPoints do

  let(:loyalty_points_payment_method) { Spree::PaymentMethod::LoyaltyPoints.create!(active: true, name: 'Loyalty_Points') }
  let(:payment) { Spree::Payment.new(amount: 50.0) }

  before(:each) do
    user = create(:user_with_loyalty_points)
    @order = create(:order_with_loyalty_points)
    payment.order = @order
    @order.user = user
    payment.payment_method = loyalty_points_payment_method
    payment.save!
    allow(Spree::Order).to receive(:find_by_number).and_return(@order)
  end

  describe 'actions' do
    it 'should return actions' do
      expect(loyalty_points_payment_method.actions).to eq(['capture', 'void'])
    end
  end

  describe 'can_void?' do
    context 'when payment state is not void' do
      before(:each) do
        payment.state = 'pending'
        payment.save!
      end

      it 'should return true if payment can be void' do
        expect(loyalty_points_payment_method.can_void?(payment)).to eq(true)
      end
    end

    context 'when payment state is void' do
      before(:each) do
        payment.state = 'void'
        payment.save!
      end

      it 'should return false if payment cannot be void' do
        expect(loyalty_points_payment_method.can_void?(payment)).to eq(false)
      end
    end
  end

  describe 'void' do

    let(:source) { nil }
    let(:gateway) { { order_id: @order.id.to_s + "-123456"  } }

    before :each do
      allow(Spree::Order).to receive(:find_by_number).and_return(@order)
      allow(@order).to receive(:loyalty_points_for).and_return(30)
    end

    it 'should be a new ActiveMerchant::Billing::Response' do
      expect(loyalty_points_payment_method.void(source, gateway)).to be_a(ActiveMerchant::Billing::Response)
    end

    it 'should receive new on ActiveMerchant::Billing::Response with true, "", {}, {}' do
      expect(ActiveMerchant::Billing::Response).to receive(:new).with(true, "", {}, {}).and_call_original
      loyalty_points_payment_method.void(source, gateway)
    end

  end

  describe 'cancel' do

    before :each do
      allow(Spree::Order).to receive(:find_by_number).and_return(@order)
      allow(@order).to receive(:loyalty_points_for).and_return(30)
    end

    it 'should be a new ActiveMerchant::Billing::Response' do
      expect(loyalty_points_payment_method.cancel).to be_a(ActiveMerchant::Billing::Response)
    end

    it 'should receive new on ActiveMerchant::Billing::Response with true, "", {}, {}' do
      expect(ActiveMerchant::Billing::Response).to receive(:new).with(true, "", {}, {}).and_call_original
      loyalty_points_payment_method.cancel
    end

  end

  describe 'credit' do

    let(:refund) { create(:refund, amount: 1) }

    before :each do
      allow(Spree::Order).to receive(:find_by_number).and_return(@order)
      allow(@order).to receive(:loyalty_points_for).and_return(30)
      allow(refund).to receive(:reimbursement).and_return(create(:reimbursement))
    end

    it 'should be a new ActiveMerchant::Billing::Response' do
      expect(loyalty_points_payment_method.credit(1, 'transaction_id', { originator: refund })).to be_a(ActiveMerchant::Billing::Response)
    end

    it 'should receive new on ActiveMerchant::Billing::Response with true, "", {}, {}' do
      expect(ActiveMerchant::Billing::Response).to receive(:new).with(true, "", {}, {}).and_call_original
      loyalty_points_payment_method.credit(1, 'transaction_id', { originator: refund })
    end

    it 'should update total users loyalty points' do
      prev_loyalty_points_balance = refund.payment.order.user.reload.energy_coins
      loyalty_points_payment_method.credit(1, 'transaction_id', { originator: refund })
      expect(refund.payment.order.user.reload.energy_coins).to eq prev_loyalty_points_balance + refund.reimbursement.return_items.last.return_authorization.loyalty_points
    end

    it 'should record the transaction in Spree::LoyaltyPointsTransaction' do
      prev_count = refund.payment.order.loyalty_points_transactions.count
      loyalty_points_payment_method.credit(1, 'transaction_id', { originator: refund })
      expect(refund.payment.order.loyalty_points_transactions.count).to eq prev_count + 1
    end

  end

  describe 'can_capture?' do
    context 'when payment state is one of [checkout, pending]' do
      before(:each) do
        payment.state = 'pending'
        payment.save!
      end

      it 'should return true if payment can be captured' do
        expect(loyalty_points_payment_method.can_capture?(payment)).to eq(true)
      end
    end

    context 'when payment state is void' do
      before(:each) do
        payment.state = 'void'
        payment.save!
      end

      it 'should return false if payment cannot be captured' do
        expect(loyalty_points_payment_method.can_capture?(payment)).to eq(false)
      end
    end
  end

  describe 'capture' do

    let(:source) { nil }
    let(:gateway) { { order_id: @order.id.to_s + "-123456"  } }

    it 'should be a new ActiveMerchant::Billing::Response' do
      expect(loyalty_points_payment_method.capture(payment, source, gateway)).to be_a(ActiveMerchant::Billing::Response)
    end

    it 'should receive new on ActiveMerchant::Billing::Response with true, "", {}, {}' do
      expect(ActiveMerchant::Billing::Response).to receive(:new).with(true, "", {}, {}).and_call_original
      loyalty_points_payment_method.capture(payment, source, gateway)
    end

  end

  describe 'source_required?' do
    it 'should return false' do
      expect(loyalty_points_payment_method).not_to be_source_required
    end
  end
end
