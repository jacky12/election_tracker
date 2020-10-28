class StateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :total_dem_votes, :total_gop_votes, :slug

  has_many :counties
end
