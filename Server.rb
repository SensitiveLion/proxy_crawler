require "sinatra"
require "pry"

INTERVAL = "not scheduled"
TIME = "not scheduled"

get "/" do
  erb :page
end

post "/" do
  INTERVAL = params["interval"]
  TIME = params["time"]
  redirect "/"
end
