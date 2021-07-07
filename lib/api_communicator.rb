require 'rest-client'
require 'json'
require 'pry'

def parse_hash(url)
  response_string = RestClient.get(url)
  #gets full API- count: 87
  response_hash = JSON.parse(response_string)
  #uses JSON to parse API string into a hash
end


def getting_urls(response_hash)
  movie_urls = {}
  response_hash["results"].each do |titles|
  #iterate through results (sub-key of response_hash)
    movie_urls = titles["films"]
    #add film titles & info to movie_urls hash
  end
  movie_urls
end


def parses_movie(movie_urls)
  parsed_movie = []
  movie_urls.each do |link|
  #iterate through movie & info list
    movie_names = RestClient.get(link)
    #web request
    parsed_movie << JSON.parse(movie_names)
    #uses web request & parses it using JSON
  end
  return parsed_movie
end


def get_character_movies_from_api(character_name)
  response_hash = parse_hash("http://www.swapi.co/api/people/")

  movie_urls = getting_urls(response_hash)

  return parses_movie(movie_urls)
end


  #parsing hash

  # response_string = RestClient.get('http://www.swapi.co/api/people/')
  # #gets full API- count: 87
  # response_hash = JSON.parse(response_string)
  # #uses JSON to parse API string into a hash

  #getting urls

  # movie_urls = {}
  # response_hash["results"].each do |titles|
  # #iterate through results (sub-key of response_hash)
  #   movie_urls = titles["films"]
  #   #add film titles & info to movie_urls hash
  # end

  #parses urls
  #
  # parsed_movie = []
  # movie_urls.each do |link|
  # #iterate through movie & info list
  #   movie_names = RestClient.get(link)
  #   #web request
  #   parsed_movie << JSON.parse(movie_names)
  #   #uses web request & parses it using JSON



# get_character_movies_from_api("Luke Skywalker")

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
    puts data["title"]
  end
end
# some iteration magic and puts out the movies in a nice list


def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
