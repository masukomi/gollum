module Precious
  class App < Sinatra::Base
    stored_password=ENV['GOLLUM_PASSWORD']
      use Rack::Auth::Basic, "Restricted Area" do |username, password|
      [username, password] == ['admin', stored_password]
    end
  end
end
