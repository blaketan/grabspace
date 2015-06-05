class Room < ActiveRecord::Base
  belongs_to :building
  has_many :events
  def self.available
  	@un_ids = unavailable.pluck(:id)
  	all.reject{|room| @un_ids.include?(room.id)}
  end
  

  def self.unavailable
  	joins(:events).merge(Event.now)
  end

end

