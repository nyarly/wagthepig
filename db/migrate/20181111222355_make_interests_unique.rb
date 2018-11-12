class MakeInterestsUnique < ActiveRecord::Migration[5.2]
  def up
    ActiveRecord::Base.connection.execute(<<-QUERY)
      DELETE
      FROM interests i1 USING interests i2
      WHERE i1.user_id = i2.user_id AND
            i1.game_id = i2.game_id AND
            i1.id > i2.id;
    QUERY

    add_index :interests, [:user_id, :game_id], unique: true
  end

  def down
    drop_index :interests, [:user_id, :game_id], unique: true
  end
end
