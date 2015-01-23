class CreateUserSocialNetworks < ActiveRecord::Migration
  def change
    create_table :user_social_networks do |t|
      t.string :twitter
      t.string :facebook
      t.string :google_plus
      t.string :instagram
      t.string :youtube
      t.string :whatsup
      t.string :linkedin
      t.string :pinterest
      t.string :flickr
      t.string :digg
      t.string :reddit
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_social_networks, :users
  end
end
