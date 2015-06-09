class Room < ActiveRecord::Base
  belongs_to :building
  has_many :events


  def self.available(time = Time.zone.now)
  	@un_ids = unavailable(time).pluck(:id)
  	all.reject{|room| @un_ids.include?(room.id)}
  end
  
  def self.unavailable(time = Time.zone.now)
  	if self.building_closed?(time)
  	  all
  	else
  	  joins(:events).merge(Event.at(time))
  	end
  end

  def available?(time = Time.zone.now)
  	Room.building_closed?(time) and self.events.at(time).empty?
  end

  def self.building_closed?(time = Time.zone.now)
  	time<time.beginning_of_day+7*60*60 or time.beginning_of_day+22*60*60 or time.saturday? or time.sunday?
  end

  def next_timing(time = Time.zone.now)
  	if Room.building_closed?(time)
  	  next_start_time(time)
  	else
  	  find_next_time(time)	
  	end
  end

private
  def next_start_time(time)
  	if time.friday? or time.sunday? or time.saturday?
  	  return time.next_week + 7*60*60
  	else
      return time.beginning_of_day + 31*60*60
  	end
  end

  def find_next_time(time)
  	@next_time = time.beginning_of_day + 2200
  	if self.available? # room is available until the start time of first event after current time
  	  @events = self.events.on(time).where("start_time >= ?" time).order('start_time')
  	  unless @events.empty? #room is available until the end of the day
  		return next_time
      else 
  		return @events.first[:start_time]
  	  end
  	else #room is available after the current event
  	  return self.events.now.first[:end_time]
  	end 
  end 
end

