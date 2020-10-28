class County < ApplicationRecord
  belongs_to :state
  validates :name, presence: true
  validates :dem, presence: true
  validates :gop, presence: true
  validates :percentage_precincts_reporting, presence: true
  # validates :total_precincts, presence: true
  # validates :precincts_reporting, presence: true

  before_create :slugify
  def slugify
    self.slug = name.parameterize
  end

  def difference
    return (self.dem - self.gop).abs
  end

  # def percentage_reporting
  #   return self.precincts_reporting.to_f/self.total_precincts
  # end

  def percentage_reporting
    return percentage_precincts_reporting/100
  end
end
