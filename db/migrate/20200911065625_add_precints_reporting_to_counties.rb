class AddPrecintsReportingToCounties < ActiveRecord::Migration[6.0]
  def change
    add_column :counties, :precincts_reporting, :integer
    add_column :counties, :total_precincts, :integer
  end
end
