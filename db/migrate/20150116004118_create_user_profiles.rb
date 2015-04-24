class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :website
      t.string :twitter
      t.string :facebook
      t.string :google
      t.string :phone
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_profiles, :users
  end
end
