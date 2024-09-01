class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :user, null: false, foreign_key: true
      t.references :matched_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :matches, [:user_id, :matched_user_id], unique: true
  end
end
