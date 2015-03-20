# This migration comes from spree (originally 20130806022521)
class DropSpreeMailMethods < ActiveRecord::Migration
  def up
    drop_table :spree_mail_methods
  end

  def down
    create_table(:spree_mail_methods) do |t|
      t.string :environment
      t.boolean :active
    end
  end
end
