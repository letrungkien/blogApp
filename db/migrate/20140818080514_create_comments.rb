class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :entry_id
      t.integer :user_id
      t.string :comment

      t.timestamps
    end

    add_index :comments, [:entry_id, :user_id, :id]
  end
end
