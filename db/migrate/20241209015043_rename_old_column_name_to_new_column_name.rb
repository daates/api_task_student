class RenameOldColumnNameToNewColumnName < ActiveRecord::Migration[8.0]
  def change
    rename_column :students, :class_id, :school_class_id
  end
end
