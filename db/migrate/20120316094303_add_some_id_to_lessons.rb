class AddSomeIdToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :course, :string

    add_column :lessons, :grade, :string

    add_column :lessons, :volume, :string

    add_column :lessons, :unit, :string

  end
end
