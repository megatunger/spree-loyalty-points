class AddPaidAtToSpreeOrder < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_orders, :paid_at, :datetime
  end
end
