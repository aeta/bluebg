class AddVerificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verified, :integer
  end
end
