module ApplicationHelper

  def grab_location
    res = HTTParty.post("https://www.googleapis.com/geolocation/v1/geolocate?key=#{ENV['GOOGLE_KEY']}")
    return {
      lat:  res['location']['lat'],
      long: res['location']['lng']
    }
  end

  def get_distance(args = {})
    origin = args.fetch(:origin)
    destination = args.fetch(:destination)
    res = HTTParty.post("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{origin[:lat]},#{origin[:long]}&destinations=#{destination[:lat]},#{destination[:long]}&key=AIzaSyCl5_4Ag_J7PW8yV-ps5ir0PMlt5a8Gp4A")
    res['rows'][0]['elements'][0]['distance']['text'][0..-4].to_f
  end

  def sort_popos_by_distance(args = {})
    lat = args.fetch(:lat, grab_location[:lat])
    long = args.fetch(:long, grab_location[:long])
    id_and_distance_array = []


    Popo.all.each do |popo|
      distance = get_distance(:origin=>{lat: lat, long: long}, :destination=>{lat: popo.lat, long: popo.long})
      id_and_distance_array << {popo.id => distance}
    end
    id_and_distance_array.sort_by! { |k| k.values[0] }
  end
  
end
