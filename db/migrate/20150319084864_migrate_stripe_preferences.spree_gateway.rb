# This migration comes from spree_gateway (originally 20131112133401)
class MigrateStripePreferences < ActiveRecord::Migration
  def up
    Spree::Preference.where("#{ActiveRecord::Base.connection.quote_column_name("key")} LIKE 'spree/gateway/stripe_gateway/login%'").each do |pref|
      pref.key = pref.key.gsub('login', 'secret_key')
      pref.save
    end
  end
end
