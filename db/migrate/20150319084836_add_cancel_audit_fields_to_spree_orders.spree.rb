# This migration comes from spree (originally 20141007230328)
class AddCancelAuditFieldsToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :canceled_at, :datetime
    add_column :spree_orders, :canceler_id, :integer
  end
end
