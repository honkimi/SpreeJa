# This migration comes from spree_static_content (originally 20090814142845)
class AddDefaultTrueToVisibleForPage < ActiveRecord::Migration
  def self.up
    change_column :spree_pages, :visible, :boolean, :default=> true
  end

  def self.down
  end
end