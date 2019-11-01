class CreateBrands < ActiveRecord::Migration[6.0]
  def up
    create_table :brands do |t|
      t.string :description
      t.belongs_to :account

      t.timestamps
    end
  end

  def down
    remove_foreign_key :brands, :account

    drop_table :brands
  end
end
