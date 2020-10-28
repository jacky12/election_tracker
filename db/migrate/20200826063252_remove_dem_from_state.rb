class RemoveDemFromState < ActiveRecord::Migration[6.0]
  def change
    remove_column :states, :dem, :integer
    remove_column :states, :gop, :integer
  end
end
