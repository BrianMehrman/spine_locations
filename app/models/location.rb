class Location < ActiveRecord::Base
  attr_accessible :name, :description, :address, :longitude, :latitude
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  
end
