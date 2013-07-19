class DeviceCommunity < ActiveRecord::Migration
  def up
    add_column :devices, :community, :string
  end

  def down
    remove_column :devices, :community
  end
end
