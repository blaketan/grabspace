class Room < ActiveRecord::Base
  belongs_to :building
  has_many :events
 

  def available
  	where(self.events.now.blank?)
  end


end

