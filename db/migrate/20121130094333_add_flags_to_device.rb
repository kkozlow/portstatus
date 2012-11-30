class AddFlagsToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :is_biznes, :boolean
    Device.reset_column_information
    Device.all.each do |device|
      device.update_attributes!(:is_biznes => true)
    end
    add_column :devices, :is_mpls, :boolean
    add_column :devices, :is_iptvtransport, :boolean
    add_column :devices, :is_iptvacces, :boolean
    add_column :devices, :is_dell, :boolean
  end
end
