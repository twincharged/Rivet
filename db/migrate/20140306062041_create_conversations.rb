class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.boolean :started_by_entity, default: false

      t.timestamps
    end
    add_index :conversations, :started_by_entity
  end
end
