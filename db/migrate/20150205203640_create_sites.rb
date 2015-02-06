class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :version
      t.string :author
      t.string :banner
      t.string :email
      t.string :twitter
      t.string :facebook
      t.string :linkedin
      t.string :google_plus

      t.timestamps null: false
    end
    add_index :sites, :name, unique: true
  end
end
