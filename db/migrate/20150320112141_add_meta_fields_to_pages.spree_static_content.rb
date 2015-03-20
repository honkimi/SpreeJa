# This migration comes from spree_static_content (originally 20091219021134)
class AddMetaFieldsToPages < ActiveRecord::Migration
  def self.up
    add_column :spree_pages, :meta_keywords, :string
    add_column :spree_pages, :meta_description, :string
  end

  def self.down
  end
end
