class AddPercentageToCounties < ActiveRecord::Migration[6.0]
  def change
    add_column :counties, :percentage_precincts_reporting, :float
  end
end
