class CreateStatusInfos < ActiveRecord::Migration
  def change
    create_table :status_infos do |t|
      t.string :status
      t.string :status_desc
      t.integer :delayed_id
      t.text :delayed_desc
      t.integer :contact_imports_id
      t.integer :user_id

      t.timestamps
    end
  end
end
