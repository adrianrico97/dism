class CreatePrograms < ActiveRecord::Migration[6.0]
  def up
    create_table :programs do |t|
      t.string :description
      t.string :version
      t.text :observations
      t.belongs_to :account

      t.timestamps
    end
  end

  def down
    drop_table :programs
  end
end
