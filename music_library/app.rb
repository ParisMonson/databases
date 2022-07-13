require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'
require_relative 'lib/database_connection'
require 'sinatra/base'
require 'sinatra/reloader'


class Application < Sinatra::Base
    configure :development do
        register Sinatra::Reloader
        also_reload 'lib/album_repository'
        also_reload 'lib/artist_repository'
      end
    def initialize(database_name, io, album_repository, artist_repository)
        DatabaseConnection.connect(database_name)
        @io = io
        @album_repository = album_repository
        @artist_repository = artist_repository
    end

    def run
        @io.puts "Welcome to the music library manager!"
        @io.puts "What would you like to do?\n1 - List all albums\n
            2 - List all artists"
        @io.print "Enter your choice:"
        user_selection = @io.gets.chomp
        if user_selection == "1"
            @io.puts "Here is the list of albums:"

            @album_repository.all.each do |album|
                @io.puts "* #{album.id} - #{album.title}"
            end
        end
    end

    

    if __FILE__ == $0
        app = Application.new(
          'music_library',
          Kernel,
          AlbumRepository.new,
          ArtistRepository.new
        )
        app.run
      end
end



