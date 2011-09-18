require 'sinatra/base'

module Circuit
  class App < Sinatra::Base
    get '/' do
      'Should work'
    end
  end
end
