class AddGradeToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :grade, :string
  end
end
