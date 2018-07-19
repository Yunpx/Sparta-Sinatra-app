class TopicController < Sinatra::Base
  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  configure :development do
    register Sinatra::Reloader
  end

  # INDEX
  get "/" do

    @topics= Topic.all
    @title = "Blog news"
    @body = "yoyo"
    erb :"pages/index"
  end

  # NEW
  get "/new" do
    topic = Topic.new

    @topic = topic
    topic.id =""
    erb :"pages/new"
  end

  # SHOW
  get "/:id" do
    id = params[:id].to_i
    # if(!session[:newss]) #making hash :newss  into session
    #   session[:newss] = []# create an array of the
    # end
    #
    # if(!session[:news].include?(id))
    #   session[:news].push(id)
    # end
    #
    # puts "user visited #{session[:news]}"

    @topic = Topic.find(id)

    erb :"pages/show"
  end

  # CREATE
  post "/" do
    topic = Topic.new

    topic.title = params[:title]
    topic.body = params[:body]
    topic.author = params[:author].to_i

    topic.save

    redirect "/"
  end

  # EDIT
  get "/:id/edit" do
    id = params[:id].to_i
    @topic = Topic.find(id)
    erb :"pages/edit"
  end

  # UPDATE
  put "/:id" do
    id = params[:id].to_i
    topic = Topic.find(id)
    topic.title = params[:title]
    topic.body = params[:body]
    topic.author = params[:author]

    topic.save

    redirect "/"
  end

  # DESTROY
  delete "/:id" do
    # get the ID
    id = params[:id].to_i

    # delete the news from the database
    Topic.destroy(id)

    # redirect back to the homepage
    redirect "/"
  end



end
