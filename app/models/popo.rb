class Popo < ActiveRecord::Base
  def self.import(file)
    CSV.foreach(file.tempfile, headers: true) do |row|
      # puts row[0]
      popos = Popo.new(name: row[0],
                       lat: row[2],
                       long: row[3],
                       restrooms: row[7],
                       address: row[1],
                       image: row[5],
                       description: row[8],
                       hours: row[10],
                       location: row[9])
      popos.save if popos.valid?
    end
  end
end
