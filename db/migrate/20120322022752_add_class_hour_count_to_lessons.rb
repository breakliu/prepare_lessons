class AddClassHourCountToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :class_hour, :string

  end
end
