class CountySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :dem, :gop, :slug, :difference, :percentage_reporting, :state_id
end
