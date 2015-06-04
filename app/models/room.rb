class Room < ActiveRecord::Base
  belongs_to :building
  has_many :events
  scope :available, -> {where(Event.now).nil?}
  scope :not_available, -> {where(Event.now)}
end

