class AddUserToRepo < ActiveRecord::Migration[6.0]
  def change
    add_reference :repos, :user, null: false, foreign_key: true
  end
end
