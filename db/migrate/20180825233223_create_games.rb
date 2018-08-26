class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.text :name
      t.integer :min_players
      t.integer :max_players
      t.text :bgg_link
      t.integer :duration_secs

      t.timestamps
    end
  end
end
