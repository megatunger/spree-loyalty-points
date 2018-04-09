class AddLoyaltyPointsBalanceToSpreeUser < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_users, :loyalty_points_balance, :integer, default: 0, null: false
  end
end
