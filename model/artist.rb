require('pg')

class Artist

    attr_accessor :title, :genere
    attr_reader :id

  def initialize(options)
    @first_name = options['first_name']
    @second_name = options['second_name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    sql = "INSERT INTO artist
    (
      first_name,
      second_name
    ) VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@first_name, @second_name]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def update()
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    sql = "
    UPDATE artist SET (
      first_name,
      second_name,
    ) =
    (
      $1,$2
    )
    RETURNING id"
    values = [@first_name, @second_name]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete()
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    sql = "DELETE * FROM artist where id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def self.delete_all()
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    sql = "DELETE FROM artist"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def self.all()
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    sql = "SELECT * FROM artist"
    db.prepare("all", sql)
    songs = db.exec_prepared("all")
    db.close()
    return songs.map { |song| Album.new(song) }
  end

end
