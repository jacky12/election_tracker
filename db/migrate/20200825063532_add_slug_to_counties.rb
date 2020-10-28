class AddSlugToCounties < ActiveRecord::Migration[6.0]
  def change
    add_column :counties, :slug, :string
  end
end
