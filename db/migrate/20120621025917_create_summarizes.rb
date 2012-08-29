class CreateSummarizes < ActiveRecord::Migration
  def change
    create_table :summarizes do |t|
      t.string :title
      t.string :course
      t.text :content
      t.integer :user_id
      t.integer :term_id

      t.timestamps
    end
  end
end
