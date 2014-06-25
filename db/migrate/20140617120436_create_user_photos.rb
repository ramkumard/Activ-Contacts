class CreateUserPhotos < ActiveRecord::Migration
  def change
    create_table :user_photos do |t|
      t.integer :user_id
      t.integer :user_album_id
      t.string :title
      t.string :photo

      t.timestamps
    end
  end
end
