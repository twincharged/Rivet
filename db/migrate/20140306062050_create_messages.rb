class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :conversation_id
      t.text :body
      t.string :photo

      t.timestamps
    end

    add_index :messages, :conversation_id
  end
end
