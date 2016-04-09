module ApplicationHelper

  def grab_location
    res = HTTParty.post("https://www.googleapis.com/geolocation/v1/geolocate?key=#{ENV['GOOGLE_KEY']}")
    return {
      lat:  res['location']['lat'],
      long: res['location']['lng']
    }
  end

  def get_distance(origin, destination)
    res = HTTParty.post("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{origin[:lat]},#{origin[:long]}&destinations=#{destination[:lat]},#{destination[:long]}&key=AIzaSyCl5_4Ag_J7PW8yV-ps5ir0PMlt5a8Gp4A")
    res['rows'][0]['elements'][0]['distance']['text'][0..-4].to_f
  end


end
