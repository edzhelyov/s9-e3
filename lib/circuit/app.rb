require 'sinatra/base'
require 'haml'
require_relative 'primitive'
require_relative 'elements'
require 'pp'

module Circuit
  class App < Sinatra::Base
    set :views, File.expand_path('../../views', __FILE__)
    set :public, File.expand_path('../../public', __FILE__)

    get '/' do
      @circuit = nil
      @primitives = [
        Primitive.new('type' => 'AND'), 
        Primitive.new('type' => 'OR'),
        Primitive.new('type' => 'XOR')
      ]

      haml :index
    end

    post '/save' do
      @circuit = params[:circuit]
      @primitives = [
        Primitive.new(:type => 'AND'), 
        Primitive.new(:type => 'OR'),
        Primitive.new(:type => 'XOR')
      ]
      @elements = Elements.from_json(params[:elements])
      pp @elements

      haml :index
    end
  end
end
