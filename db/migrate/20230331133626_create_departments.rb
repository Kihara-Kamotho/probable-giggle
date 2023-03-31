class CreateDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :motto
      t.string :mission

      t.timestamps
    end
  end
end
