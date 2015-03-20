# This migration comes from spree_i18n (originally 20141112121313)
class AddTranslationsToProductProperties < ActiveRecord::Migration
  def up
    params = { value: :string }
    Spree::ProductProperty.create_translation_table!(params, { migrate_data: true })
  end

  def down
    Spree::ProductProperty.drop_translation_table! migrate_data: true
  end
end
