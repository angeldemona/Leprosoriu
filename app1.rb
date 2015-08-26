require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do
db = get_db 
db.execute 'CREATE TABLE IF NOT EXISTS "Users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT, "username" TEXT, "phone" TEXT,
 "datastamp" TEXT,"barber" TEXT, "color" TEXT)'

 end



 get '/' do
 erb "Hello!"
  end


get '/about' do
 erb :about
end

get '/visit' do
  erb :visit
end


post '/visit' do
 @username = params[:username]
 @phone = params[:phone]
 @datetime = params[:datetime]
 @barber = params[:barber]
  

 hh = { :username => 'Enter your name', 
         :phone => 'Enter your phone',
        :datetime => 'Enter your data and time'}

@error = hh.select {|key,_| params[key] ==""}.value.join(",")

  if @error != ''
 return erb :visit
end
   db = get_db
   db.exexute 'insert into users (username, phone,datestapmp,barber,color) values (?,?,?,?,?)',[@username, @phone,@datetime,@barber,@color] 
   erb "Ok, username is #{@username}, #{@phone}, #{@datatime}, #{@barber}, #{@color}"
end

def get_db
 return SQLite3::Database.new 'barbershop.db'
end
