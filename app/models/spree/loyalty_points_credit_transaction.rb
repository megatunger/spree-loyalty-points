module Spree
  class LoyaltyPointsCreditTransaction < LoyaltyPointsTransaction
    after_create :update_user_balance
    before_create :update_balance

    private

      def update_user_balance
        user.increment(:energy_coins, loyalty_points)
        user.save!
      end

      def update_balance
        self.balance = user.energy_coins + loyalty_points
      end

  end
end
