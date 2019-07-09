class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.text :reply
      t.boolean :active
      t.integer :rating
      t.string :by
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
