class AddBggIdColumn < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.string :bgg_id
    end
  end
end
