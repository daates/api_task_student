class RenameClassToSchoolClass < ActiveRecord::Migration[8.0]
  def change
    rename_table :classes, :school_classes
  end
end
