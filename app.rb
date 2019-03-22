require "sinatra"
require "sinatra/reloader" if development?

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get "/" do
    erb :index
  end

  get "/minimal.html" do
    erb :minimal
  end

  get "/minimal" do
    erb :minimal
  end

  get "/complete" do
    erb :complete
  end
end
