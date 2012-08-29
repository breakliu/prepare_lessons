class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title
      t.string :course
      t.text :content
      t.integer :user_id
      t.integer :term_id

      t.timestamps
    end
  end
end
