require('pg')

  require_relative("../db/console.rb")

class Artist

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
      genre,
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
      genre,
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
