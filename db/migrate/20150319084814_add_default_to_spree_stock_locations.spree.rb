# This migration comes from spree (originally 20140717185932)
class AddDefaultToSpreeStockLocations < ActiveRecord::Migration
  def change
    unless column_exists? :spree_stock_locations, :default
      add_column :spree_stock_locations, :default, :boolean, null: false, default: false
    end
  end
end
