class AddTermIdToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :term_id, :integer
  end
end
