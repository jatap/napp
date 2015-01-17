class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_id, :string
    add_column :users, :avatar_filename, :string
    add_column :users, :avatar_size, :integer
    add_column :users, :avatar_content_type, :string
  end
end
