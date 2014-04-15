class Building < ActiveRecord::Base
  reverse_geocoded_by :lat, :lng
  has_many :rooms
  
end
