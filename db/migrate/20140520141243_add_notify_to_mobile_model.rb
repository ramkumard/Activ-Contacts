class AddNotifyToMobileModel < ActiveRecord::Migration
  def change
      add_column :mobiles, :notify_user, :boolean,:default =>false
  end
end
