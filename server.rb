require 'sinatra'
require 'pry'
require 'csv'

def movies_full_list(filename)
  movies = []
  CSV.foreach(filename, headers: true) do |row|
    movies << row.to_hash
  end
  movies
end

before do
  @all_movies ||= movies_full_list('movies.csv')
end

get '/' do
  erb :index
end

get '/movies' do
  @search_array = []
  if params[:query]
    @query = params[:query]
  end
  ### make a page number
  ### page number shows only 20 items per page
  ### show the next 20 items after the 1st has been showsn
  ### MATH (page number(variable) * 20 items)
  ###

  if params[:page]
    then
    @page = params[:page].to_i
    else @page = 1
  end

  @sorted_movies = @all_movies.sort_by {|movie| movie["title"]}
  erb :movies
end

get '/movies/:id' do
  @current_movie = @all_movies.find {|movie| movie['id'] == params[:id]}
  @id = @current_movie['id']
  @title = @current_movie['title']
  @year = @current_movie['year']
  @synopsis = @current_movie['synopsis']
  @rating = @current_movie['rating']
  @genre = @current_movie['genre']
  @studio = @current_movie['studio']
  erb :id
end
