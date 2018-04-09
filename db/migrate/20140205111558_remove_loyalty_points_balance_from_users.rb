class RemoveLoyaltyPointsBalanceFromUsers < ActiveRecord::Migration[4.2]
  def change
    if Spree.user_class.column_names.include? 'loyalty_points_balance'
      remove_column Spree.user_class.table_name, :loyalty_points_balance
    end
  end
end
