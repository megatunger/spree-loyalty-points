# frozen_string_literal: true

module SpreeLoyaltyPoints
  module Spree
    module PaymentDecorator
      def self.prepended(base)
        base.include ::Spree::LoyaltyPoints
        base.include ::Spree::Payment::LoyaltyPoints

        base.validates :amount, numericality: { greater_than: 0 }, if: :by_loyalty_points?
        base.validate :redeemable_user_balance, if: :by_loyalty_points?
        base.scope :state_not, ->(s) { where('state != ?', s) }

        fsm = base.state_machines[:state]
        fsm.after_transition from: fsm.states.map(&:name) - [:completed], to: [:completed], do: :notify_paid_order

        fsm.after_transition from: fsm.states.map(&:name) - [:completed], to: [:completed], do: :redeem_loyalty_points, if: :by_loyalty_points?
        fsm.after_transition from: [:completed], to: fsm.states.map(&:name) - [:completed], do: :return_loyalty_points, if: :by_loyalty_points?
      end

      private

      def invalidate_old_payments
        return if store_credit? || by_loyalty_points?

        order.payments.with_state('checkout').where("id != ?", id).each do |payment|
          payment.invalidate! unless payment.store_credit?
        end
      end

      def notify_paid_order
        if all_payments_completed?
          order.touch :paid_at
        end
      end

      def all_payments_completed?
        order.payments.state_not('invalid').all? { |payment| payment.completed? }
      end

      ::Spree::Payment.prepend self
    end
  end
end
