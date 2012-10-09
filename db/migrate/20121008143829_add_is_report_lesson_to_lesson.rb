class AddIsReportLessonToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :is_report, :boolean
  end
end
