class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :bio
      t.date :birth_date
      t.string :gender
      t.string :location
      t.string :interests
      t.string :language

      t.timestamps
    end
  end
end
