class AddEnergyCoinsToUsers < ActiveRecord::Migration[4.2]
  def change
    unless Spree.user_class.column_names.include? 'energy_coins'
      add_column Spree.user_class.table_name, :energy_coins, :integer, default: 0
    end
  end
end
