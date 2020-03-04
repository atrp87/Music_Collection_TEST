require('pg')

class Album

  attr_accessor :title, :genere
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
  end

  def save()
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    sql = "INSERT INTO album
    (
      title,
      genre
    ) VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @genre]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def update()
    db = PG.connect({ dbname: 'album', host: 'localhost' })
    sql = "
    UPDATE album SET (
      title,
      genre
    ) =
    (
      $1,$2
    )
    RETURNING id"
    values = [@title, @genre]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  # def delete()
  #   db = PG.connect({ dbname: 'music', host: 'localhost' })
  #   sql = "DELETE * FROM album where id = $1"
  #   values = [@id]
  #   db.prepare("delete", sql)
  #   db.exec_prepared("delete", values)
  #   db.close()
  # end
  # def self.find(id)
  #   db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
  #   sql = "SELECT * FROM pizza_orders WHERE id = $1"
  #   values = [id]
  #   db.prepare("find", sql)
  #   results = db.exec_prepared("find", values)
  #   db.close()
  #   order_hash = results.first
  #   order = PizzaOrder.new(order_hash)
  #   return order
  # end
  def self.delete_all()
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    sql = "DELETE * FROM album"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def self.all()
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    sql = "SELECT * FROM music"
    db.prepare("all", sql)
    songs = db.exec_prepared("all")
    db.close()
    return songs.map { |song| Album.new(song) }
  end
end
