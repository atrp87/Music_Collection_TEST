# require("pry")

require_relative("../model/album.rb")
# require_relative("../models/artist.rb")

Album.delete_all
# Artist.delete_all

  album1 = Album.new( {'title' => 'mirror mirror', 'genre' => 'metal'} )

  album2 = Album.new( {'title' => 'cosmos factory', 'genre' => 'rock'} )

  album1.save
  album2.save



  # artist1 = Artist.new( {'first_name' => 'Marcus', 'last_name' => 'Siepen'} )
  #
  # artist2 = Artist.new( {'first_name' => 'tom', 'last_name' => 'Fogerty'} )
  #
  # artist2.save
  # artist1.save
