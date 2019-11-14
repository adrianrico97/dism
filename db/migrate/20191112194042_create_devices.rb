class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :description
      t.text :observations
      t.string :serial_number
      t.string :code
      t.string :category
      t.decimal :price
      t.date :purchase_date
      t.belongs_to :account
      t.belongs_to :model
      t.belongs_to :brand

      t.timestamps
    end

    create_join_table :devices, :programs
    
    create_table :devices_users_relations do |t|
      t.belongs_to :device
      t.belongs_to :user
      t.date :assignment_date
      t.date :deassignment_date
    end
  end
end