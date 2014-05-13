class CreateContactImports < ActiveRecord::Migration
  def change
    create_table :contact_imports do |t|
      t.integer :user_id
      t.boolean :status
      t.timestamps
    end
  end
end
