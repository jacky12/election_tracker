class State < ApplicationRecord
    has_many :counties , dependent: :destroy
    validates :name, presence: true

    before_create :slugify
    # sets slug for state before setting it in our database

    def slugify
        self.slug = name.parameterize
    end

    def advantage_score
        (:dem - :gop).abs
    end

    def total_dem_votes
        counties.sum(:dem)
    end

    def total_gop_votes
        counties.sum(:gop)
    end
end
