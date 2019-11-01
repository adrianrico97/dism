class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    create_table :users do |t|
      t.string :login
      t.string :password_digest
      t.string :email
      t.string :name
      t.string :surname_1
      t.string :surname_2
      t.string :id_document_number
      t.string :rol
      t.boolean :active

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
