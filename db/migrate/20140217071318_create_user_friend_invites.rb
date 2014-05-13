class CreateUserFriendInvites < ActiveRecord::Migration
  def change
    create_table :user_friend_invites do |t|
      t.integer :user_id
      t.string :friend_invite_id
      t.boolean :status
      t.timestamps
    end
  end
end
