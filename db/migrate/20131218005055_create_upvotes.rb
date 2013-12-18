class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.integer :post_id, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :upvotes, [:post_id, :user_id], :unique => true
    add_column :posts, :score, :integer, :null => false
    add_index :posts, :score
  end
end
