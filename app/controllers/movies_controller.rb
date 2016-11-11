class MoviesController < ApplicationController
    def index
        @movies = Movie.all
    end
    
    def show
        id = params[:id] # retrieve movie ID from URI route
        @movie = Movie.find(id) # look up movie by unique ID
        # will render app/views/movies/show.html.haml by default
    rescue
        flash[:notice] = "Movie with a given ID could not be found."
        redirect_to movies_path
    end
    
    def new
        @movie = Movie.new
    end
    
    def create
        params.require(:movie)
        permitted = params[:movie].permit(:title,:rating,:release_date,:description)
        @movie = Movie.create!(permitted)
        flash[:notice] = "#{@movie.title} was successfully created."
        redirect_to movie_path(@movie)
    end
    
    def edit
        @movie = Movie.find params[:id]
    end
    
    def update
        @movie = Movie.find params[:id]
        permitted = params[:movie].permit(:title, :rating, :release_date,:description)
        @movie.update_attributes!(permitted)
        respond_to do |client_wants|
            client_wants.html {redirect_to movie_path(@movie)}
            client_wants.xml {render :xml => @movie.to_xml}
        end
        flash[:notice] = "#{@movie.title} was successfully updated!"
    end
        
        
end

# in app/controllers/movies_controller.rb

