class CreateHes < ActiveRecord::Migration
  def change
    create_table :hes do |t|
      t.text :address
      t.boolean :blocked

      t.timestamps
    end

    add_column :devices, :he_id, :integer

  end
end
