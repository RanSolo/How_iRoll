require 'active_record'

class Person < ActiveRecord::Base
   validates :name, uniqueness: { message: "already exists." }
   validates :name, format: { with: /[a-zA-Z]/, message: "is not a valid person name, as it does not include any letters." }

   has_many :logs
  #  has_many :locations, through: :logs
end
