require_relative 'lib/album_repository'
require_relative 'lib/database_connection'

DatabaseConnection.connect('music_library')
repo = AlbumRepository.new
album = repo.find(3)

puts "#{album.title}, #{album.release_year}"



