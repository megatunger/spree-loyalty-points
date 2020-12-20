require 'active_support/concern'

module Spree
  module LoyaltyPoints
    extend ActiveSupport::Concern

    def loyalty_points_for(amount, purpose = 'award')
      loyalty_points = if purpose == 'award' && eligible_for_loyalty_points?(amount)
        (amount * SpreeLoyaltyPoints::Config.loyalty_points_awarding_unit).floor
      elsif purpose == 'redeem'
        (amount / SpreeLoyaltyPoints::Config.loyalty_points_conversion_rate).ceil
      else
        0
      end
    end

    def eligible_for_loyalty_points?(amount)
      amount >= SpreeLoyaltyPoints::Config.min_amount_required_to_get_loyalty_points
    end

  end
end
