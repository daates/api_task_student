class AddUniqueIndexToStudentsAuthToken < ActiveRecord::Migration[8.0]
  def change
    add_index :students, :auth_token, unique: true
  end
end
