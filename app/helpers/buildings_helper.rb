module BuildingsHelper
  def compass(building, lat_lng)
    Geocoder::Calculations.compass_point(building.bearing_from(lat_lng)) 
  end
end
