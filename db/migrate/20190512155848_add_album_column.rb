class AddAlbumColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :studio, :boolean, default: true, null: false
  end
end
