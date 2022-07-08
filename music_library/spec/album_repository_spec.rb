require "album_repository"

def reset_albums_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
end

describe AlbumRepository do
    before(:each) do 
        reset_albums_table
    end

    it "returns all albums" do
        repo = AlbumRepository.new

        albums = repo.all

        expect(albums.length).to eq 2

        expect(albums[0].id).to eq 1
        expect(albums[0].title).to eq 'Doolittle'
        expect(albums[0].release_year).to eq 1989
        expect(albums[0].artist_id).to eq 1

        expect(albums[1].id).to eq 2
        expect(albums[1].title).to eq 'Surfer Rosa'
        expect(albums[1].release_year).to eq 1988
        expect(albums[1].artist_id).to eq 1
    end
    it "returns a single Album object" do
        repo = AlbumRepository.new
        album = repo.find(2)
        expect(album.id).to eq 2
        expect(album.title).to eq "Surfer Rosa"
        expect(album.release_year).to eq 1988
    end
    it "creates a new album record" do
        repo = AlbumRepository.new
        album = Album.new
        album.title = 'Trompe le Monde'
        album.release_year = 1991
        album.artist_id = 1
        repo.create(album)

        all_albums = repo.all
        expect(all_albums.length).to eq 3
        expect(all_albums[2].title).to eq 'Trompe le Monde'
        expect(all_albums[2].release_year).to eq 1991
        expect(all_albums[2].artist_id).to eq 1
    end
end