class Movie < ActiveRecord::Base

  def self.all_ratings
   return ['G', 'PG', 'PG-13', 'R']
  end

  def self.filter(filter_param)
   #w[title, release_date].include?(sort_param) ? sort_param : "title"
   logger.debug 'Entering filtered sort'
   logger.debug  "Filter: #{filter_param} #{filter_param.class}"
   #f(filter_param === nil)
   #  return movies
   #nd
   h = eval(filter_param)
#if (h === nil) 
#      logger.debug "Hash null... returning"
#      return @movies
#   end
   array = Array.new
   h.each do |k,v|
      logger.debug "#{k}"
      array << k
   end
  
   filtered_list = Array.new
   @movies = Movie.all
   @movies.each do |m|
   if(array.include?(m.rating.upcase))
#if(m.rating.upcase === 'PG')
         filtered_list << m
      end
    end
    logger.debug 'Leaving filtered sort'
    @movies = filtered_list
    logger.debug "#{filtered_list}"
    return(@movies)
  end


end
