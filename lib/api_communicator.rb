require 'rest-client'
require 'json'
require 'pry'


def parse_hash (url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
end


def getting_urls (response_hash)
  movie_urls = {}
  response_hash["results"].each do |titles|
    movie_urls = titles["films"]
  end
  movie_urls
end


def parsed_movie (movie_urls)
  parsed_movie = []
  movie_urls.each do |link|
    movie_names = RestClient.get(link)
    parsed_movie << JSON.parse(movie_names)
  end
  return parsed_movie
end


def get_character_movies_from_api(character_name)
  #** Parse Hash with helper method **#
  response_hash = parse_hash('http://www.swapi.co/api/people/')
  #** Parse Hash without helper method **#
  # response_string = RestClient.get("http://www.swapi.co/api/people/")
  # response_hash = JSON.parse(response_string)

  #** Getting Urls with helper method **#
  movie_urls = getting_urls(response_hash)
  #** Getting Urls without helper method **#
  # movie_urls = {}
  # response_hash["results"].each do |titles|
  #   movie_urls = titles["films"]
  # end

  #** Parses Urls with helper method
  return parsed_movie(movie_urls)
  # parsed_movie = []
  # movie_urls.each do |link|
  #   movie_names = RestClient.get(link)
  #   parsed_movie << JSON.parse(movie_names)
  # end
  # return parsed_movie
end

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.


def print_movies(films)
  films.each do |data|
    puts "#{data["title"]}: Episode #{data["episode_id"]}"
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
