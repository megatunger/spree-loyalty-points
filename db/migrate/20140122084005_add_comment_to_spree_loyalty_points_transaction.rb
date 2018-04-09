class AddCommentToSpreeLoyaltyPointsTransaction < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_loyalty_points_transactions, :comment, :string
  end
end
