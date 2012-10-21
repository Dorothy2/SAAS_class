class Movie < ActiveRecord::Base

  def self.all_ratings
   return ['G', 'PG', 'PG-13', 'R']
  end

  def self.filter(filter_param)
   #w[title, release_date].include?(sort_param) ? sort_param : "title"
   logger.info 'Entering filtered sort'
   logger.info  "Filter: #{filter_param} #{filter_param.class}"
   if(filter_param.class == NilClass)
      logger.debug "Filter param null ..."
      @movies = Movie.all
      return
   end
#h = eval(filter_param)
#if (h.nil?) 
#   logger.debug "Hash null... returning"
# @movies = Movie.all
#      return
#   end
   array = Array.new
   filter_param.each do |k,v|
      logger.debug "#{k}"
      array << k
   end
  
   filtered_list = Array.new
   @movies = Movie.all
   @movies.each do |m|
   if(array.include?(m.rating.upcase))
         filtered_list << m
      end
    end
    logger.debug 'Leaving filtered sort'
    @movies = filtered_list
    logger.debug "#{filtered_list}"
    return(@movies)
  end


end
