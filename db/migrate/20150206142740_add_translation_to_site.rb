class AddTranslationToSite < ActiveRecord::Migration
  def up
    Site.create_translation_table!({
      banner: :string
    }, {
      migrate_data: true
    })
    remove_column :sites, :banner
  end

  def down
    Site.drop_translation_table! migrate_data: true
    add_column :sites, :banner
  end
end
