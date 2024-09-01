class CreateSwipes < ActiveRecord::Migration[7.0]
  def change
    create_table :swipes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :swiped_user, null: false, foreign_key: { to_table: :users }
      t.string :direction, null: false

      t.timestamps
    end

    add_index :swipes, [:user_id, :swiped_user_id], unique: true
  end
end
