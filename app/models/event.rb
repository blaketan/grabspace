class Event < ActiveRecord::Base
  belongs_to :room
  scope :today, -> {where("start_time >= ?", Time.now.beginning_of_day)}
 
end
