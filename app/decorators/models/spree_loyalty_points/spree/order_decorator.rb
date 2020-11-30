# frozen_string_literal: true

module SpreeLoyaltyPoints
  module Spree
    module OrderDecorator
      extend ActiveSupport::Concern

      def self.prepended(base)
        base.include ::Spree::LoyaltyPoints
        base.include ::Spree::Order::LoyaltyPoints

        base.has_many :loyalty_points_transactions, as: :source
        base.has_many :loyalty_points_credit_transactions, as: :source
        base.has_many :loyalty_points_debit_transactions, as: :source

        base.scope :loyalty_points_not_awarded, -> { includes(:loyalty_points_credit_transactions).where(spree_loyalty_points_transactions: { source_id: nil } ) }
        base.scope :with_hours_since_payment, ->(num) { where('`spree_orders`.`paid_at` < ? ', num.hours.ago) }
        base.scope :with_uncredited_loyalty_points, ->(num) { with_hours_since_payment(num).loyalty_points_not_awarded }

        fsm = base.state_machines[:state]
        fsm.after_transition from: fsm.states.map(&:name) - [:complete], to: [:complete], do: :complete_loyalty_points_payments
      end

      # allows to filter out payment methods that don't work for guest checkout,
      # for example loyalty points.
      # The filtering works for payment methods that have guest_checkout: false
      # in their preferences attributes (you need to create them like that)
      def available_payment_methods_for_user(user)
        default_methods = available_payment_methods
        if user.present?
          default_methods
        else
          default_methods.select { |m| m.preferences.fetch(:guest_checkout, true) }
        end
      end

      ::Spree::Order.prepend self
    end
  end
end
