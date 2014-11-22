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
  redirect '/movies'
end

get '/movies' do
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
