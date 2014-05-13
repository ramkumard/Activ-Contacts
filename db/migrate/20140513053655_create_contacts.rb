class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :type
      t.string :phones, array: true, default: []
      t.date :dob
      t.string :email
      t.string :organisation
      t.integer:user_id
      t.string:note
      t.timestamps
    end
  end
end


