Spree.user_class.class_eval do
  validates :energy_coins, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  with_options foreign_key: :user_id do
    has_many :loyalty_points_transactions, class_name: Spree::LoyaltyPointsTransaction
    has_many :loyalty_points_debit_transactions, class_name: Spree::LoyaltyPointsDebitTransaction
    has_many :loyalty_points_credit_transactions, class_name: Spree::LoyaltyPointsCreditTransaction
  end

  def loyalty_points_balance_sufficient?
    energy_coins >= Spree::Config.loyalty_points_redeeming_balance
  end

  def has_sufficient_loyalty_points?(order)
    loyalty_points_equivalent_currency >= order.total
  end

  def loyalty_points_equivalent_currency
    energy_coins * Spree::Config.loyalty_points_conversion_rate
  end

end
