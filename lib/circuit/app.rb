require 'sinatra/base'
require 'haml'
require_relative 'primitive'

module Circuit
  class App < Sinatra::Base
    set :views, File.expand_path('../../views', __FILE__)
    set :public, File.expand_path('../../public', __FILE__)

    get '/' do
      @circuit = nil
      @primitives = [Primitive.new, GreePrimitive.new]
      haml :index
    end

    post '/save' do
      @circuit = params[:circuit]
      @primitives = [Primitive.new, GreePrimitive.new]
      haml :index
    end
  end
end
