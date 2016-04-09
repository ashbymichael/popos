module ApplicationHelper

  def grab_location
    res = HTTParty.post("https://www.googleapis.com/geolocation/v1/geolocate?key=#{ENV['GOOGLE_KEY']}")
    return {
      lat:  res['location']['lat'],
      long: res['location']['long']
    }
  end

end
