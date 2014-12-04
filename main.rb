require "sinatra"
require "sinatra/reloader" if development?

get "/" do
    @title = "Samantha Marie Ballard's Portfolio"
    @discripton = "This site shows off all the awesome things that Samantha Marie Ballard has done"
    @home = "active"
    erb :home 
end

get '/about' do
    @title = "About Me"
    @discripton = "This page provides a short discription of Samantha Marie Ballard"
    @about = "active"
    erb :about
end

get '/work' do
    @title = "My Art"
    @discripton = "This page provides links to the several wonderful pieces of Samantha Marie Ballard"
    @work = "active"
    erb :work
end

get '/work01' do
    @title = "My Art"
    @discripton = "This page provides links to the several wonderful pieces of Samantha Marie Ballard"
    erb :work01
end

get '/tweets' do
    require "twitter"
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "Fve9gntyXbThL8tZiZqogdkUa"
      config.consumer_secret     = "pxy2qZIgRaNDm9vgOeuOhGKTZM4X1EQ10dhWUCEpjwfq8GCG0Q"
      config.access_token        = "1148752556-M6Q7yPxduGLiBt7cWHjjFPsY1ic1zQfvWihSyN6"
      config.access_token_secret = "SfCwD8KcZyN1oEyd2wjZI6Rdkm2osWoaB3bKwnH3bZBmo"
    end
    
   @search_results = client.search("@Mercer", result_type: "recent").take(15).collect do |tweet|
    #"#{tweet.user.screen_name}: #{tweet.text}"
       tweet
    end 
    
    @title = "Tweets about My Alma Mater"
    @discripton = "This page provides links to the tweets Samantha Marie Ballard finds interesting"
    @tweets = "active"
    erb :tweets
end

get '/insta' do
    require "instagram"
    @title = "Instagram"
    @discripton = "This page provides links to the pictures from instagram that Samantha Marie Ballard finds interesting"
    @works = "active"


    Instagram.configure do |config|
        config.client_id = "c0ff18f1fcfb4edda98ebbeb9321825f"
        config.client_secret = "fd91d5f326644d0390f2a94f677de537"
    end
 
  client = Instagram.client(:access_token => session[:access_token])
  tags = client.tag_search('MercerBears')
    @photos = Array.new
  #html << "<h2>Tag Name = #{tags[0].name}. Media Count =  #{tags[0].media_count}. </h2><br/><br/>"
  for media_item in client.tag_recent_media(tags[0].name)
      @photos.push(media_item)
    #html << "<img src='#{media_item.images.thumbnail.url}'>"
  end
    erb :insta
end

