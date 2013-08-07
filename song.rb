require 'dm-core'
require 'dm-migrations'

# database connection
DataMapper.setup(:default, 'postgres://rfang:1007-ecnu@localhost/test')

# define a model
class Song
  include DataMapper::Resource
  
  property :id, Serial
  property :title, String # up to 256 chars
  property :lyrics, Text
  property :length, Integer
  property :released_on, Date
end

DataMapper.finalize

get ('/songs/styles.css') { scss :styles }

get '/songs' do
  @songs = Song.all
  erb :songs
end

get '/songs/:id' do
  @song = Song.get(params[:id])
  erb :show_song
end
