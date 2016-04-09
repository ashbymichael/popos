class Popo < ActiveRecord::Base
  def self.import(file)
    CSV.foreach(file.tempfile, headers: false) do |row|
      popos = Popo.new(name: row[1],
                       lat: row[3],
                       long: row[4],
                       restrooms: row[17],
                       address: row[2],
                       image: row[7],
                       description: row[29],
                       hours: row[31],
                       location: row[20])
      student.save if student.valid?
    end
  end
end
