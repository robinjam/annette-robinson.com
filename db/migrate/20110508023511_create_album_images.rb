class CreateAlbumImages < ActiveRecord::Migration
  def self.up
    create_table :album_images do |t|
      t.references :album
      t.references :image
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :album_images
  end
end
