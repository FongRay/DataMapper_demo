# myapp.rb
require 'rubygems'
require 'sinatra'
require 'rack'
require 'sinatra/reloader' if development? # gem install sinatra-reloader
require 'haml' # gem install haml
require 'sinatra/activerecord'
require 'sass'
require 'slim'

require './song'

set :server, 'webrick' 
set :bind, '10.110.162.177'
set :port, '9999'

#set :public_folder, 'public'
#set :views, 'views'

#puts "This is process #{Process.pid}"
  
=begin
get '/:name' do
    "Hello, this is #{ params[:name] }"
end
=end

get ('/styles.css') { scss :styles }

get '/' do
    erb :home
end

get '/about' do
    erb :about
end

get '/contact' do
    erb :contact
end

get '/instance' do
    @name = "FangRui"
    erb :show
end

get '/time' do
    time = Time.now;
    "Now is #{ time.strftime('%I:%M %p') }"
end

get '/ip' do
    "Your IP address is #{ @env['REMOTE_ADDR'] } "
    "Request ip is #{ request.ip }"
end

not_found do
    status 404
    erb :not_found
#halt 404, 'page not found'
end


__END__
@@home
<p>Welcome to this website that's all about the songs of the great
Frank Sinatra.</p>
<img src="/images/sinatra.jpg" alt="Frank Sinatra">

@@about
<p>This site is a demonstration of how to build a website using
Sinatra. -- by rfang@vmware.com</p>

@@contact
<p>You can contact me by sending an email to rfang at vmware.com</p>

@@show
<h1>Hello <%= @name %>!</h1>

@@not_found
<h1>sorry, page not found --------- by rfang@vmware.com</h1>
