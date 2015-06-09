class Building < ActiveRecord::Base
  reverse_geocoded_by :lat, :lng
  has_many :rooms, dependent: :destroy

  def rooms_available
    return self.rooms.available
  end



end
