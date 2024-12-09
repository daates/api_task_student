class RemoveNotNullConstraintFromColumnName < ActiveRecord::Migration[8.0]
  def change
    change_column :students, :auth_token, :string, null: true
  end
end
