class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer    :user_id, null: false
      t.references :likeable, polymorphic: true

      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, [:user_id, :likeable_type, :likeable_id], unique: true
  end
end
