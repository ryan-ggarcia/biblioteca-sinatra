require "sinatra/base"
require "sinatra/json"
require "json"

require_relative "db/database"

Dir[File.join(__dir__, "model", "*.rb")].each { |f| require f }
Dir[File.join(__dir__, "dao", "*.rb")].each { |f| require f }
Dir[File.join(__dir__, "middleware", "*.rb")].each { |f| require f }

class App < Sinatra::Base
  helpers Sinatra::JSON

  configure :development do
    require "sinatra/reloader"
    register Sinatra::Reloader
  end

end



Dir[File.join(__dir__, "controller", "*.rb")].each { |f| require f }