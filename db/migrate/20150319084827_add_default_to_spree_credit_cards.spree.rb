# This migration comes from spree (originally 20140805171035)
class AddDefaultToSpreeCreditCards < ActiveRecord::Migration
  def change
    add_column :spree_credit_cards, :default, :boolean, null: false, default: false
  end
end
