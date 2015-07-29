class MoviesController < ApplicationController

	def index
		@movietimes = [["Under 90 minutes", "Under 90 minutes"], ["Between 90 and 120 minutes", "Between 90 and 120 minutes"], ["Over 120 minutes", "Over 120 minutes"]]
		@movies = Movie.all
		if params.has_key?(:title) || params.has_key?(:director) || params.has_key?(:runtime_in_minutes)
			@movies = @movies.where("title like ?", "%#{params[:title]}%")
			@movies = @movies.where("director like? ", "%#{params[:director]}%")
			if params[:runtime_in_minutes] == "Under 90 minutes"
				@movies = @movies.where("runtime_in_minutes < 90 ", "%#{params[:runtime_in_minutes]}%")
			elsif params[:runtime_in_minutes] == "Between 90 and 120 minutes"
				@movies = @movies.where("runtime_in_minutes >= 90 AND runtime_in_minutes <= 120 ", "%#{params[:runtime_in_minutes]}%")
			else
				@movies = @movies.where("runtime_in_minutes > 120 ", "%#{params[:runtime_in_minutes]}%")

		end

				
							
		end
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