# This migration comes from spree_i18n (originally 20131009091000)
class AddTranslationsToOptionValue < ActiveRecord::Migration
  def up
    params = { name: :string, presentation: :string }
    Spree::OptionValue.create_translation_table!(params, { migrate_data: true })
  end

  def down
    Spree::OptionValue.drop_translation_table! migrate_data: true
  end
end
