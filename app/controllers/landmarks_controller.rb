class LandmarksController < ApplicationController

  get '/landmarks/new' do # route is GET request to localhost:9393/landmarks/new, which presents form to create a new landmark
    erb :'/landmarks/new' # renders the new.erb view file, which is found in the landmarks/ subfolder within the views/ folder
  end

  post '/landmarks' do # route is a POST request to localhost:9393/landmarks. It receives the POST request sent by the form to create a new landmark; it receives the data submitted in form to create new landmark, which ended up in params hash
    @landmark = Landmark.create(params[:landmark]) # params[:landmark] is the landmark hash (nested inside params hash), and we pass landmark hash to #create
# ^instantiate a landmark instance with its @name and @year_completed attribute values set via mass assignment. Store the landmark instance in @landmark instance variable to pass to view file.
    erb :'landmarks/show' # render the show.erb view file within the landmarks/ subfolder within views/ folder to show the landmark just created in the form
  end

  get '/landmarks' do # route is GET request to localhost:9393/landmarks (the index page to display all landmarks)
    @all_landmarks = Landmark.all # @all_landmarks stores an array of all landmark instances

    erb :'/landmarks/index' # render the index.erb view file, which is found in landmarks/ subfolder within the views/ folder
  end

  get '/landmarks/:id' do # show page to show a single landmark - route is GET request to localhost:9393/landmarks/@id attribute value of whichever landmark instance you wish to see goes here to replace :id route variable
    @landmark = Landmark.find(params[:id]) # find the landmark instance by its @id attribute value, which is the value corresponding to the :id key in params hash

    erb :'/landmarks/show' # render the show.erb view file, which is found within the landmarks/ subfolder within the views/ folder
  end

  get '/landmarks/:id/edit' do # route is a GET request to localhost:9393/landmarks/@id value of whatever landmark instance user wants to edit goes here/edit. When the user navigates to this URL, they see a form to edit a landmark
    @landmark = Landmark.find(params[:id])

    erb :'landmarks/edit' # render the edit.erb view file, which is found in the landmarks/ subfolder within the views/ folder
  end

  post '/landmarks/:id' do # route is a POST request to localhost:9393/landmarks/@id of whatever landmark instance user is editing goes here. This route receives the data submitted by the user in the form to edit a landmark
    @landmark = Landmark.find(params[:id])
    @landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    @landmark.save

    redirect("/landmarks/#{@landmark.id}") # redirect to show page to show the landmark that was just edited
  end

end
