class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.belongs_to :department, foreign_key: true, null: false

      t.timestamps
    end
  end
end
