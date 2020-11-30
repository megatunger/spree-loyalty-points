# frozen_string_literal: true

module SpreeLoyaltyPoints
  module Spree
    module UserDecorator
      def self.prepended(base)
        base.validates :loyalty_points_balance, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

        base.with_options foreign_key: :user_id do
          has_many :loyalty_points_transactions, class_name: ::Spree::LoyaltyPointsTransaction.to_s
          has_many :loyalty_points_debit_transactions, class_name: ::Spree::LoyaltyPointsDebitTransaction.to_s
          has_many :loyalty_points_credit_transactions, class_name: ::Spree::LoyaltyPointsCreditTransaction.to_s
        end
      end

      def loyalty_points_balance_sufficient?
        loyalty_points_balance >= ::Spree::Config.loyalty_points_redeeming_balance
      end

      def has_sufficient_loyalty_points?(order)
        loyalty_points_equivalent_currency >= order.total
      end

      def loyalty_points_equivalent_currency
        loyalty_points_balance * ::Spree::Config.loyalty_points_conversion_rate
      end

      ::Spree.user_class.prepend self
    end
  end
end
