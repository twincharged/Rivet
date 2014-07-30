class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.references :shareable, polymorphic: true
      t.text :body
      t.boolean :public, default: false
      t.string :photo
      t.string :youtube_string
      t.integer :likes_count

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, [:user_id, :public]
    add_index :posts, [:user_id, :public, :likes_count]
    add_index :posts, [:user_id, :shareable_type, :shareable_id, :public], name: "specific_shareable_index"
  end
end
