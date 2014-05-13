require 'active_record'

class Location < ActiveRecord::Base
  validates :name, uniqueness: { message: "already exists."}
  validates :name, format: { with: /[a-zA-Z]/, message: "is not a valid location name, as it does not include any letters." }

  has_many :injury_outcomes
end
