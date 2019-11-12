class CreateModels < ActiveRecord::Migration[6.0]
  def up
    create_table :models do |t|
      t.string :description
      t.belongs_to :brand

      t.timestamps
    end
  end
  def down
    drop_table :models
  end
end
