require_relative File.join("..", "app", "model", "db")


# Use an in-memory Derby DB for the test suite
class DB
  def self.connect
    if not @pool
      require_relative File.join("..", "app", "model", "db_migrator")
      @pool = Sequel.connect("jdbc:derby:memory:fakedb;create=true",
                             :max_connections => 10,
                             # :loggers => [Logger.new($stderr)]
                             )

      DBMigrator.setup_database(@pool)
    end
  end
end


require_relative File.join("..", "app", "main")
require 'sinatra'
require 'rack/test'

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  ArchivesSpaceService
end


RSpec.configure do |config|
  config.include Rack::Test::Methods

  user_manager = UserManager.new
  puts "creating test1 user ..."
  user_manager.create_user("test1", "Tester", "1", "local")
  db_auth = DBAuth.new
  db_auth.set_password("test1", "test1_123")


  # Roll back the database after each test
  config.around(:each) do |example|
    DB.open(true) do
      example.run
      raise Sequel::Rollback
    end
  end
end