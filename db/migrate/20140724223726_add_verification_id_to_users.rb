class AddVerificationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verification_id, :string
  end
end
