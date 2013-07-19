class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string "name"
      t.string "ip", :null => false
      t.timestamps
    end
  end
end
