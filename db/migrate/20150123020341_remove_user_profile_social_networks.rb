class RemoveUserProfileSocialNetworks < ActiveRecord::Migration
  def change
    remove_column :user_profiles, :twitter
    remove_column :user_profiles, :facebook
    remove_column :user_profiles, :google
  end
end
