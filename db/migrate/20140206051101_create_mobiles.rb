class CreateMobiles < ActiveRecord::Migration
  def change
    create_table :mobiles do |t|
      t.integer :user_id
      t.string  :phone_no
      t.boolean :status
      t.string  :tag
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.timestamps
    end
  end
end
