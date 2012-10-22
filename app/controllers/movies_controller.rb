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
    logger.debug "session:  #{session[:sort]}"
    if(sort_column.nil?)
       @movies = Movie.all
    else
       logger.debug "using sort: #{sort_column}"
       @movies = Movie.order(sort_column)
#session[:sort] = sort_column
    end
#logger.debug "at end of index session:  #{session[:sort]}"

#logger.debug "Ratings: #{ratings} ratings nil? #{ratings.nil?} ratings.length #{ratings.length}"
#if ratings.nil?
#        return(@movies)
#    end
    
#logger.debug "check ratings #{ratings.class?}"
    if(! ratings.nil?) 
      @movies = Movie.filter(ratings)
    end
if(params[:sort] == nil && sort_column != nil)
           redirect_path ="#{movies_path}?sort=#{sort_column}"
           if(!ratings.nil?)
              ratings.each  do |key, value|
                 redirect_path = redirect_path + "&ratings[#{key}]=ratings[#{key}]"
              end

           end
           logger.debug "redirect path #{redirect_path}"
           redirect_to  redirect_path
        end
    logger.debug "#{@movies}"
    return(@movies)
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
     logger.debug "params #{params[:sort].class} session #{session[:sort].class}"
     if(params[:sort] != nil)
        foo = params[:sort]
        logger.debug "foo #{foo.class}"
        if(foo.class != NilClass)
          session[:sort] = params[:sort]
          logger.debug "Storing sort #{session[:sort]}"
          return(params[:sort])
        end
      elsif(session[:sort] != nil)
         logger.debug "Retrieving sort #{params[:sort]}"
         foo = session[:sort]
         return foo
       
     end
     logger.debug "No param or session value."
     return nil

  end

  def ratings
    logger.debug "params #{params[:ratings].class} session #{session[:ratings].class}"
    if(params[:ratings] != nil)
       ratings = params[:ratings]
       session[:ratings] = params[:ratings]
    elsif(session[:ratings] != nil)
       logger.debug "Retrieving sort from cache"
       ratings = session[:ratings]
    else
       logger.debug "No param or session value for ratings"
    end
    logger.debug "From ratings: #{ratings.class}"
    return ratings

  end

# def hilite
#   return ".hilite"
# end

  def filter(ratings) 
     logger.debug 'Starting controller filter: '
     movies = @movies
#movies = Movie.filter(movies)
     Movie.filter(ratings)
     return @movies
#return @movies
  end
end
