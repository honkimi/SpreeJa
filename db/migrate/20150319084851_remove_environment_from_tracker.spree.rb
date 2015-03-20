# This migration comes from spree (originally 20150128032538)
class RemoveEnvironmentFromTracker < ActiveRecord::Migration
  def up
    Spree::Tracker.where('environment != ?', Rails.env).update_all(active: false)
    remove_column :spree_trackers, :environment
  end
end
