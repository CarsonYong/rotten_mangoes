class MoviesController < ApplicationController

  def index
    @movietimes = [["All",""],["Under 90 minutes", "0:90"], ["Between 90 and 120 minutes","90:120"], ["Over 120 minutes", "120:9999999999"]]
    @movies = Movie.all
    movie_duration = params[:runtime_in_minutes].split(':') if params.has_key?(:runtime_in_minutes) and not params[:runtime_in_minutes].empty?
    @movies = @movies.by_search(params[:search]) if params.has_key?(:search) and not params[:search].empty?
    @movies = @movies.by_duration(movie_duration[0], movie_duration[1]) if params.has_key?(:runtime_in_minutes) and not params[:runtime_in_minutes].empty?
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

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :director, :release_date,  :runtime_in_minutes, :poster_image_url, :description, :image, :search
    )
  end

end