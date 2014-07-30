class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.boolean :accepted, default: false

      t.timestamps
    end
    add_index :relationships, [:follower_id, :accepted]
    add_index :relationships, [:followed_id, :accepted]
    add_index :relationships, [:followed_id, :follower_id, :accepted], unique: true, name: "specific_relationships_index"
  end
end
