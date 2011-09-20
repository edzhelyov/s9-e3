require 'sinatra/base'
require 'haml'
require_relative 'primitive'

module Circuit
  class App < Sinatra::Base
    set :views, File.expand_path('../../views', __FILE__)
    set :public, File.expand_path('../../public', __FILE__)

    get '/' do
      @primitives = [Primitive.new, GreePrimitive.new]
      haml :index
    end
  end
end
