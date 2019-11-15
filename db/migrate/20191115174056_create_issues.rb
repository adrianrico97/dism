class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :title
      t.text :description
      t.date :date
      t.string :state
      t.string :priority
      t.belongs_to :device
      t.belongs_to :user

      t.timestamps
    end
  end
end
