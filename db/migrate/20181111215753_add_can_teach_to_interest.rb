class AddCanTeachToInterest < ActiveRecord::Migration[5.2]
  def change
    change_table :interests do |t|
      t.boolean :can_teach, nil: false, default: false
    end
  end
end
