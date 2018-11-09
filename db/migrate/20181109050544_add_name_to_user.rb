class AddNameToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |users|
      users.string :name
      users.string :bgg_username
    end
  end
end
