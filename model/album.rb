require('pg')

class Album

    attr_accessor :title, :genere
    attr_reader :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id=options['artist_id']
  end

  def save()
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    sql = "INSERT INTO album
    (
      artist_id,
      title,
      genre
    ) VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@artist_id,@title, @genre]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def update()
    db = PG.connect({ dbname: 'album', host: 'localhost' })
    sql = "
    UPDATE album SET (
      artist_id,
      title,
      genre
    ) =
    (
      $1,$2,$3
    )
    RETURNING id"
    values = [@artist_id,@title, @genre]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

   def delete()
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    sql = "DELETE * FROM album where id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
   end

  def self.delete_all()
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    sql = "DELETE FROM album"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def self.all()
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    sql = "select * from album"
    db.prepare("all", sql)
    songs = db.exec_prepared("all")
    db.close()
    return songs.map { |song| Album.new(song) }
  end

  def self.all_by_artist(artist_id)
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    sql = "select * from album where artist_id=#{artist_id};"
    db.prepare("all", sql)
    songs = db.exec_prepared("all")
    db.close()
    return songs.map { |song| Album.new(song) }
  end

  def self.find(artist_id)
   db = PG.connect({ dbname: 'music', host: 'localhost' })
   sql = "SELECT *
   FROM artist
   WHERE id = $1"
   values = [artist_id]
   db.prepare("find", sql)
   artists = db.exec_prepared("find")
   db.close()
  return artists.map { |artist| Artist.new(artist) }
 end

end
