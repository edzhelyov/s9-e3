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
        Primitive.factory('NOT')
      ]
    end

    C = Schema.new

    get '/' do
      C.add_element(AND.new, 100, 100)
      C.add_element(OR.new, 100, 50)
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
      C.toggle_source(params[:id], params[:source])
    end

    get '/connect' do
      C.connect(params[:from], params[:to], params[:source])
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
