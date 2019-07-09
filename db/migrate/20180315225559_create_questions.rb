class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :query
      t.boolean :active
      t.date :expires_on
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
