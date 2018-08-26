class MakeInterestsJoin < ActiveRecord::Migration[5.2]
  def change
    add_reference(:interests, :game, foreign_key: true, null: false)
    add_reference(:interests, :user, foreign_key: true, null: false)
  end
end
