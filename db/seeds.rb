require 'dbf'
require 'open-uri'

def load_table(file_name)
  DBF::Table.new(file_name)
end

def download_image(image_path, file_name)
  open(file_name, 'wb') do |file|
    file << open(image_path).read
  end
end

def clean_seating(val)
  if val == "N"
    return 0
  end

  if val == "Y"
    return 1
  end
end

def clean_year(val)
  return val.to_i unless val == nil
  val
end

def clean_image(img)
  img.gsub!(/JPG/, "jpg")
end

popos = load_table("db/POPOS.dbf")

popos.each do |record|
  Popo.create!(
    name: record.name,
    lat: record.lattitue,
    lng: record.longitude,
    address: record.popos_addr,
    location_type: record.type,
    location: record.location,
    image: clean_image(record.pic_file),
    description: record.descriptio,
    hours: record.hours,
    hours_type: record.hours_type,
    restrooms: record.restrooms,
    landscape: record.landscapin,
    accessibility: record.accessibil,
    year: clean_year(record.year),
    seating: clean_seating(record.seating),
    seating_description: record.seating_no
    )
end