class MoviesController < ApplicationController

   attr_reader :all_ratings
   def initialize
     super()
     logger.debug "Ratings #{Movie.all_ratings}"
     @all_ratings = Movie.all_ratings
     logger.debug "From controller  #{@all_ratings}"
   end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    Movie.filtered_sort('title', 'G')
    @movies = Movie.all
    #@movies = Movie.order(params[:sort])
#@movies = Movie.order(sort_column)
    #ogger.debug "#{params}"
#movies = Movie.filtered_sort(params[:sort], ratings)
    #movies = Movie.filtered_sort('title', 'G')
    #logger.debug('Movie path: ' + movies_path)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def sort_column 
     %w[title, release_date].include?(params[:sort]) ? params[:sort] : "title"
  end

  def ratings
    ratings = params[:ratings]
    logger.debug "#{ratings}"

  end

#def filter()
#     collection = Movie.order(sort_column)
#     collection.each do |movie|
#        logger.debug "#{movie.title} #{movie.rating}"
#     end
#Movie.where('rating = "G"')
#  end


end
