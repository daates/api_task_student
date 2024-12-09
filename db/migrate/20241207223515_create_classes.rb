class CreateClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :school_classes do |t|
      t.integer :number, null: false
      t.string :letter, null: false
      t.integer :students_count, null: false, default: 0
      t.references :school, foreign_key: true, null: false
      t.timestamps
    end
  end
end
