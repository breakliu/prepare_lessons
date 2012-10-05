class AddContentToLessonHour < ActiveRecord::Migration
  def change
    add_column :lesson_hours, :content, :text
  end
end
