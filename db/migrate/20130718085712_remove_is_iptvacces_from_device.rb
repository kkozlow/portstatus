class RemoveIsIptvaccesFromDevice < ActiveRecord::Migration
  def up
    remove_column :devices, :is_iptvacces
  end

  def down
    add_column :devices, :is_iptvacces, :boolean
  end
end
