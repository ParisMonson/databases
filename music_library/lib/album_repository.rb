require_relative './album'

class AlbumRepository
  # Selecting all records
  # No arguments
  def all
    albums = []
    sql = "SELECT * FROM albums;"
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
        album = Album.new
        album.id = record["id"].to_i
        album.title = record["title"]
        album.release_year = record["release_year"].to_i
        album.artist_id = record["artist_id"].to_i
        albums << album
    end
    albums
  end
  def find(id)
    sql = "SELECT * FROM albums WHERE id = $1;"
    result_set = DatabaseConnection.exec_params(sql, [id]) 
    album = Album.new
    record = result_set[0]
    album.id = record["id"].to_i 
    album.title = record["title"] 
    album.release_year = record["release_year"].to_i 
    album.artist_id = record["artist_id"] 
    album
  end

  def create(album)
    sql = "INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);"
    DatabaseConnection.exec_params(sql, [album.title, album.release_year, album.artist_id])
  end
end