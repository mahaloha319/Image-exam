class RemoveRereferenceToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_reference :users, :user, foreign_key: true
  end
end
