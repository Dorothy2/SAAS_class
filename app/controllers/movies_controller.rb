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
    logger.debug 'Starting index...'
    if(sort_column.nil?)
       @movies = Movie.all
    else
       @movies = Movie.order(sort_column)
    end

    if ratings.nil? || eval(ratings).nil?
        return
    end
    
#logger.debug "check ratings #{ratings.class?}"
    @movies = Movie.filter(ratings)
#end
#   tmp = @movies.copy
#   #movies = nil
#   filtered_movies = filter(ratings)
#   combined_movies = Array.new
#   tmp.each do |movie|
#     filtered_movies.each  do |fm|
#        if(fm.title == movie.title && fm.rating == movie.rating)
#             logger.debug "match: #{movie.title} #{movie.rating}"
#             @movies << movie
#        end
#     end # filtered movies each
#   end # movies.each
    logger.debug "#{@movies}"
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
     if(params != nil)
      %w[title, release_date].include?(params[:sort]) ? params[:sort] : "title"
     end
  end

  def ratings
    ratings = params[:ratings]
    logger.debug "#{ratings}"

  end

  def hilite
    return ".hilite"
  end

  def filter(ratings) 
     logger.debug 'Starting controller filter: '
     movies = @movies
#movies = Movie.filter(movies)
     Movie.filter(ratings)
     return @movies
#return @movies
  end
end
