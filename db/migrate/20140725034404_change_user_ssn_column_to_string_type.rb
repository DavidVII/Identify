class ChangeUserSsnColumnToStringType < ActiveRecord::Migration
  def change
    remove_column :users, :ssn
    add_column :users, :ssn, :string
  end
end
