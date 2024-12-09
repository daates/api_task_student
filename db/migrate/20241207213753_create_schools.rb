class CreateSchools < ActiveRecord::Migration[8.0]
  def change
    create_table :schools do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.timestamps
    end
    add_index :schools, :name, unique: true
  end
end
