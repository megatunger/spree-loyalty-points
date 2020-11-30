# frozen_string_literal: true

module SpreeLoyaltyPoints
  module Spree
    module PaymentMethodDecorator
      def self.prepended(base)
        base.scope :loyalty_points_type, -> { where(type: '::Spree::PaymentMethod::LoyaltyPoints') }
      end

      def self.loyalty_points_id_included?(method_ids)
        loyalty_points_type.where(id: method_ids).size != 0
      end

      ::Spree::PaymentMethod.prepend self
    end
  end
end
