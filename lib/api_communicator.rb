require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  character_info = response_hash["results"].find do |character_info|
    character_info["name"].downcase == character_name
  end
  film_urls = character_info["films"]

  film_urls.map do |film_url|
    response_string = RestClient.get(film_url)
    response_hash = JSON.parse(response_string)
  end
end

def get_movie_info_from_api(movie)
  response_string = RestClient.get('http://www.swapi.co/api/films/')
  response_hash = JSON.parse(response_string)
  response_hash["results"].find do |movie_hash|
    movie_hash["title"].downcase == movie
  end
end

def print_movies(films)
  films.each do |film|
    puts film["title"]
  end
end

def print_movie_info(film)
  film.delete("characters")
  film.delete("planets")
  film.delete("starships")
  film.delete("vehicles")
  film.delete("species")
  film.each do |attribute, value|
    puts "#{attribute}: "
    puts value
    puts ""
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

def show_movie_info(movie)
  film = get_movie_info_from_api(movie)
  print_movie_info(film)
end
