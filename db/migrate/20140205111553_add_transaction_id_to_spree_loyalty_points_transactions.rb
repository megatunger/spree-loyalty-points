class AddTransactionIdToSpreeLoyaltyPointsTransactions < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_loyalty_points_transactions, :transaction_id, :string
  end
end
