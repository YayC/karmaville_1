class AddKarmaSumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :karma_sum, :integer
    add_index :users, :karma_sum
  end
end
