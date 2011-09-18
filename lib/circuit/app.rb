require 'sinatra/base'

module Circuit
  class App < Sinatra::Base
    set :views, File.expand_path('../../views', __FILE__)

    get '/' do
      haml :index
    end
  end
end
