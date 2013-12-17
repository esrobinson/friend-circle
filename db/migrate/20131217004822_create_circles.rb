class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :name, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :circles, [:name, :user_id], :unique => true
  end
end
