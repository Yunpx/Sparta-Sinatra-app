require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader" if development?
require "sinatra/cookies"
require "pg"
require_relative "controllers/topic_controller.rb"
require_relative "models/topic.rb"

use Rack::MethodOverride
run TopicController
