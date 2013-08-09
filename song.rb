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
  
  def released_on=date
    super Date.strptime(date, '%m/%d/%Y')
  end
  
end

DataMapper.finalize

#get ('/songs/styles.css') { scss :styles }
#get ('/songs/:id/styles.css') { scss :styles }

get '/songs' do
  @songs = Song.all
  erb :songs
end

post '/songs' do
  song = Song.create(params[:song])
  if song.saved?
    redirect to("/songs/#{ song.id }")
  else
    "Insert Data Failed.."
  end
end

get '/songs/new' do
  @song = Song.new
  erb :new_song
end

get '/songs/:id' do
  @song = Song.get(params[:id])
  erb :show_song
end

put '/songs/:id' do
  song = Song.get(params[:id])
  song.update(params[:song])
  redirect to("/songs/#{ song.id }")
end

delete '/songs/:id' do
  Song.get(params[:id]).destroy
  redirect to('/songs')
end

get '/songs/:id/edit' do
  @song = Song.get(params[:id])
  erb :edit_song
end