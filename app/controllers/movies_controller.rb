class MoviesController < ApplicationController

  def index
    @movietimes = [["",""],["Under 90 minutes", "Under 90 minutes"], ["Between 90 and 120 minutes", "Between 90 and 120 minutes"], ["Over 120 minutes", "Over 120 minutes"]]
    @movies = Movie.all
    # if params.has_key?(:title) || params.has_key?(:director) || params.has_key?(:runtime_in_minutes)
      @movies = @movies.by_director(params[:director]) if params.has_key?(:director) and not params[:director].empty?
      @movies = @movies.by_title(params[:title]) if params.has_key?(:title) and not params[:title].empty?
      @movies = @movies.by_duration(params[:runtime_in_minutes]) if params.has_key?(:runtime_in_minutes) and not params[:runtime_in_minutes].empty?
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    #@movie.image = params[:movie][:image]

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end
  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movies_path(@movie)
    else
      render :edit
    end
  end

  def search
    
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image
    )
  end

end