# frozen_string_literal: true

class AddUserRefToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_reference :questions, :user, null: false, foreign_key: true
    rename_column :questions, :user_id, :author_id

    add_reference :answers, :user, null: false, foreign_key: true
    rename_column :answers, :user_id, :author_id
  end
end
