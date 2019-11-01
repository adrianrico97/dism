class CreateAccounts < ActiveRecord::Migration[6.0]
  def up
    create_table :accounts do |t|
      t.string :description

      t.timestamps
    end
  end

  def down
    drop_table :accounts
  end
end
