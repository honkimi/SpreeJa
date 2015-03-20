# This migration comes from spree_i18n (originally 20150224152415)
class AddDeletedAtToTranslationTables < ActiveRecord::Migration
  def change
    add_column :spree_product_translations, :deleted_at, :datetime
    add_index :spree_product_translations, :deleted_at
  end
end
