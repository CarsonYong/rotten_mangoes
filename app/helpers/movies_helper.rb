module MoviesHelper

  def formatted_date(date)
    date.strftime("%b %d, %Y")
  end

  def movie_description(movie)
    output = h(truncate(movie.description, length: 200, omission: '...'))
    output += link_to('Read More', movie_path(movie)) if movie.description.size > 200
    output.html_safe
  end 

end