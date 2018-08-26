class AddReferencesToGame < ActiveRecord::Migration[5.2]
  def change
    add_reference(:games, :event, foreign_key: true, null: false)
    add_reference(:games, :suggestor, foreign_key: {to_table: 'users'}, null: false)
  end
end
