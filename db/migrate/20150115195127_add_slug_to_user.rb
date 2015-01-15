class AddSlugToUser < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    change_column_null :users, :slug, false
    add_index  :users, :slug, unique: true
  end
end
