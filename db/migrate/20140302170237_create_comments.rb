class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer    :user_id, null: false
      t.text	     :body, null: false
      t.references :threadable, polymorphic: true
      t.integer :likes_count

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, [:user_id, :threadable_type, :threadable_id], name: "specific_comments_index"
    add_index :comments, [:user_id, :threadable_type, :threadable_id, :likes_count], name: "specific_comments_index_for_likes"
  end
end
