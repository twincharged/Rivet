class CreateConversationUsers < ActiveRecord::Migration
  def change
    create_table :conversation_users do |t|
      t.integer :user_id
      t.integer :conversation_id
      t.boolean :read, default: false

      t.timestamps
    end

    add_index :conversation_users, :user_id
    add_index :conversation_users, :conversation_id
    add_index :conversation_users, [:user_id, :read]
  end
end
