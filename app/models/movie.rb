class Movie < ActiveRecord::Base

  def self.all_ratings
   return ['G', 'PG', 'PG-13', 'R']
  end

  def self.filtered_sort(sort_param, filter_param)
   #return(self.order(sort_param))
   if(sort_param) === nil
     sort_param = 'title'
   end
   #%w[title, release_date].include?(sort_param) ? sort_param : "title"
   logger.debug 'Entering filtered sort'
   logger.debug  "Filter: #{filter_param} #{filter_param.class}" 
#for debugging
#movies = Movie.order('title')
#logger.debug "movies #{movies}"
   #Movies = Movie.order(sort_param)
   #if(filter_param === nil)
   #  return movies
   #end
   #h = eval(filter_param)
   #if(h === nil) 
   #  logger.debug "Hash null... returning"
   #  return movies
   #end
   #Array = Array.new
   #h.each do |k,v|
   #   logger.debug "#{k}"
   #   array << k
   #end
  
   #filtered_list = Array.new
   #movies.each do |m|
   # if(array.include?(m.rating.upcase))
#if(m.rating.upcase === 'PG')
   #     filtered_list << m
   #  end
   #end
   #logger.debug 'Leaving filtered sort'
   #logger.debug "#{filtered_list}"
   #return(filtered_list)
  end


end
