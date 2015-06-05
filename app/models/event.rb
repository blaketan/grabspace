class Event < ActiveRecord::Base
  belongs_to :room

  def self.now
  	at(Time.zone.now)
  end

  def self.at(time)
  	where("start_time <= ? AND end_time >= ?", time, time)
  end

  def self.today
  	on(Time.zone.now)
  end

  def self.on(day)
  	where("start_time >= ?", day.beginning_of_day)
  end
end
