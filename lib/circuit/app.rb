require 'sinatra/base'
require 'haml'
require_relative '../../vendor/batik/lib/batik'
require_relative 'primitive'
require_relative 'elements'
require 'pp'

module Circuit
  class App < Sinatra::Base
    set :views, File.expand_path('../../views', __FILE__)
    set :public, File.expand_path('../../public', __FILE__)

    def primitives
      @primitives = [
        Primitive.factory('AND'), 
        Primitive.factory('OR'),
        Primitive.factory('XOR')
      ]
    end

    get '/' do
      @circuit = nil
      primitives

      haml :index
    end

    post '/save' do
      @circuit = params[:circuit]
      primitives

      @elements = Elements.from_json(params[:elements])
      pp @elements

      haml :index
    end
  end
end
