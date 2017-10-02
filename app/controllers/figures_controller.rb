class FiguresController < ApplicationController
  get '/figures/new' do # route is a GET request to localhost:9393/figures/new, which presents form to create a new figure
    erb :'figures/new' # render the new.erb view file, which is found in the figures/ subfolder within the views/ folder
  end

  get '/figures' do # route is a GET request to localhost:9393/figures, where all figures are displayed
    @all_figures = Figure.all # @all_figures stores an array of all figure instances

    erb :'figures/index' # render the index.erb view file, which is within the figures/ subfolder within the views/ folder
  end

  post '/figures' do #route is a POST request to localhost:9393/figures. Route receives the data submitted in the form to create a new figure
    @figure = Figure.create(params[:figure])
    # The argument passed to #create is the figure hash (nested inside params hash)
    # figure hash looks like {"name" => "@name value", "title_ids" => [array of @id values of title instances], "landmark_ids" => [array of @id values of landmark instances]}
    # Instantiate @figure instance with its @name attribute value set through mass assignment, and
    # now we can also call @figure.titles and the array of title instances belonging to @figure instance is returned
    # Calling @figure.landmarks returns the array of landmark instances belonging to @figure instance
    if !params[:title][:name].empty? # If it is true that the user entered a new title for the new figure in the form field (value is not an empty string), then
      @figure.titles << Title.create(params[:title]) # argument passed to #create is title hash nested inside params hash. title hash looks like {"name" => "@name value of title instance"}
      # instantiate a title instance with its @name attribute value set through mass assignment and shovel it into the array of title instances belonging to the @figure instance
    end

    if !params[:landmark][:name].empty? # If it is true that the user entered a new landmark for the new figure in the form field (value is not an empty string), then
      @figure.landmarks << Landmark.create(params[:landmark]) # argument passed to #create is landmark hash nested inside params hash. landmark hash looks like: {"name" => "@name value of landmark instance"}
      # instantiate a landmark instance with its @name attribute value set (and its @year_completed set if user entered value in form field) via mass assignment and shovel it into the array of landmark instances belonging to the @figure instance
    end

    @figure.save
    redirect("/figures/#{@figure.id}") # redirect to the show page, which displays the figure just created
  end

  get '/figures/:id' do # show page to display a single figure
    @figure = Figure.find(params[:id])

    erb :'figures/show' # render the show.erb view file, which is found in the figures/ subfolder within the views/ folder
  end

  get '/figures/:id/edit' do # route is GET request to localhost:9393/figures/some @id of figure instance/edit to present the form to edit a single figure
    @figure = Figure.find(params[:id]) # @figure stores the figure instance found by its @id value, i.e., whatever the user typed in URL to replace :id route variable

    erb :'figures/edit' # render the edit.erb view file, which is found in the figures/ subfolder within the views/ folder
  end

  post '/figures/:id' do # route is a POST request to localhost:9393/figures/some @id of figure instance. Route receives the data submitted in the edit form
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure]) # this updates @name of the @figure instance, as well as the EXISTING title and landmark instances that belong to the @figure instance, via mass assignment

    if !params[:title][:name].empty? # If the user entered a title name in the edit form to create a new title for the figure, (value is NOT an empty string),
      @figure.titles << Title.create(params[:title]) # instantiate a new title instance with its @name attribute value set via mass assignment, and add this title instance to the figure instance's array of title instances belonging to it
    end
    # Although a landmark instance has 2 attributes, a user only has to fill in the landmark's name field in edit form to create a new landmark for the figure
    if !params[:landmark][:name].empty? # If it's true that the user entered a landmark name in edit form (value is not an empty string),
      @figure.landmarks << Landmark.create(params[:landmark]) # Instantiate landmark instance with its @name and (possibly) @year_completed attributes set via mass assignment. Then shovel landmark instance into @figure instance's array of landmark instances belonging to it
    end

    @figure.save # saving info about the @figure instance's new landmarks and titles
    redirect to "/figures/#{@figure.id}" # redirect to the show page to show the figure we just edited
  end

end
