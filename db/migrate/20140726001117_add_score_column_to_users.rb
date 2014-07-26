class AddScoreColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :score, :decimal, default: 0.0
  end
end
