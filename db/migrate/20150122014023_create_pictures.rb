class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.attachment :avatar
      t.string :avatar_url
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :pictures, :users
  end
end
