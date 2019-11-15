class CreateTrackings < ActiveRecord::Migration[6.0]
  def change
    create_table :trackings do |t|
      t.text :description
      t.datetime :date
      t.belongs_to :issue
      t.belongs_to :user

      t.timestamps
    end
  end
end
