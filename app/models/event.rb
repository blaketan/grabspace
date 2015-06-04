class Event < ActiveRecord::Base
  belongs_to :room
  scope :today, -> {where("start_time >= ?", Time.zone.now.beginning_of_day)}
  scope :now, -> {where("start_time <= ? AND end_time >= ?", Time.zone.now, Time.zone.now)} 
end
