# This migration comes from spree (originally 20130423223847)
class SetDefaultShippingRateCost < ActiveRecord::Migration
  def change
    change_column :spree_shipping_rates, :cost, :decimal, default: 0, precision: 8, scale: 2
  end
end
