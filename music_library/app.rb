require_relative 'lib/album_repository'
require_relative 'lib/database_connection'

DatabaseConnection.connect('music_library')
repo = AlbumRepository.new
album = repo.find(2)

puts album.title



