# frozen_string_literal: true

# Comment
class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.string :body, null: false
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
