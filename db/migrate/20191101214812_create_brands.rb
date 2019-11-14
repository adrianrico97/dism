class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.string :description
      t.belongs_to :account

      t.timestamps
    end
  end
end
