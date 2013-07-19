class CreateDevicesUsersTable < ActiveRecord::Migration
  def self.up
    create_table :devices_users, :id => false do |t|
        t.references :device
        t.references :user
    end
    add_index :devices_users, [:device_id, :user_id]
    add_index :devices_users, :user_id
  end

  def self.down
    drop_table :devices_users
  end
end
