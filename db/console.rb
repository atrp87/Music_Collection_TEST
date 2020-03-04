require_relative("../model/album.rb")
require_relative("../model/artist.rb")

Album.delete_all
Artist.delete_all

  artist1 = Artist.new( {'first_name' => 'Marcus', 'second_name' => 'Siepen'} )

  artist2 = Artist.new( {'first_name' => 'tom', 'second_name' => 'Fogerty'} )

artist2.save
artist1.save

  album1 = Album.new( {'artist_id'=>artist1.id,'title' => 'mirror mirror', 'genre' => 'metal'} )

  album2 = Album.new( {'artist_id'=>artist2.id,'title' => 'cosmos factory', 'genre' => 'rock'} )

album1.save
album2.save

Album.all
