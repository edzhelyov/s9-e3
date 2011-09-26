require 'sinatra/base'
require 'haml'
require_relative '../../vendor/batik/lib/batik'
require_relative 'primitive'
require_relative 'schema'
require_relative 'element'
require 'pp'

module Circuit
  class App < Sinatra::Base
    set :views, File.expand_path('../../views', __FILE__)
    set :public, File.expand_path('../../public', __FILE__)

    def primitives
      @primitives = [
        Primitive.factory('AND'), 
        Primitive.factory('OR'),
        Primitive.factory('XOR'),
        Primitive.factory('NOT'),
        Primitive.factory('SWITCH')
      ]
    end

    C = Schema.new

    get '/' do
      @circuit = C
      primitives

      haml :index
    end

    get '/add_element' do
      primitive = Primitive.factory(params[:type])
      C.add_element(primitive, params[:x], params[:y])

      C.to_s
    end

    get '/toggle_source' do
      C.toggle_source(params[:id].to_i, params[:source].to_i)

      C.to_s
    end

    get '/connect' do
      C.connect(params[:from].to_i, params[:to].to_i, params[:source].to_i)
      p C

      C.to_s
    end

    get '/clean' do
      C = Schema.new

      redirect '/'
    end

#    post '/save' do
#      @circuit = params[:circuit]
#      primitives
#
#      @elements = Elements.from_json(params[:elements])
#      pp @elements
#
#      haml :index
#    end
  end
end
