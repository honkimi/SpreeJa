# This migration comes from spree (originally 20140713140455)
class CreateSpreeReturnAuthorizationReasons < ActiveRecord::Migration
  def change
    create_table :spree_return_authorization_reasons do |t|
      t.string :name
      t.boolean :active, default: true
      t.boolean :mutable, default: true

      t.timestamps null: false
    end

    reversible do |direction|
      direction.up do
        Spree::ReturnAuthorizationReason.create!(name: 'もっと安い店があった')
        Spree::ReturnAuthorizationReason.create!(name: '到着予定日に届かなかった')
        Spree::ReturnAuthorizationReason.create!(name: '商品の中身が足りない')
        Spree::ReturnAuthorizationReason.create!(name: '不良品')
        Spree::ReturnAuthorizationReason.create!(name: '違う商品が届いた')
        Spree::ReturnAuthorizationReason.create!(name: '商品説明と違う')
        Spree::ReturnAuthorizationReason.create!(name: 'いらなくなった')
        Spree::ReturnAuthorizationReason.create!(name: '間違って注文した')
        Spree::ReturnAuthorizationReason.create!(name: '家族や友人が無断で注文した')
      end
    end

    add_column :spree_return_authorizations, :return_authorization_reason_id, :integer
    add_index :spree_return_authorizations, :return_authorization_reason_id, name: 'index_return_authorizations_on_return_authorization_reason_id'
  end
end
