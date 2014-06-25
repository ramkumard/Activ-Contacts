class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.string :approved
      t.boolean :status
      t.text :message

      t.timestamps
    end
  end
end
