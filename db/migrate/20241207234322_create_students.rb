class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :surname, null: false
      t.references :school_classes, foreign_key: true, null: false
      t.references :school, foreign_key: true, null: false
      t.string :auth_token, null: false
      t.timestamps
    end

    add_index :students, :auth_token, unique: true

  end
end
