class CreateGroupStudyPlans < ActiveRecord::Migration
  def change
    create_table :group_study_plans do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :term_id
      t.integer :group_id

      t.timestamps
    end
  end
end
