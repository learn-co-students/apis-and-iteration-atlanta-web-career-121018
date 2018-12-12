def welcome
  puts "Welcome!"
end

def get_search_method
  puts "Would you like to search by character or by movie?"
  search_method = gets.chomp.downcase
  if search_method == "movie"
    get_movie_from_user
  elsif  search_method == "character"
    get_character_from_user
  else
    puts "Invalid entry try again"
    get_search_method
  end
end

def get_movie_from_user
  puts "Please enter a movie name"
  movie = gets.chomp.downcase
  show_movie_info(movie)
end

def get_character_from_user
  puts "Please enter a character name"
  character = gets.chomp.downcase
  show_character_movies(character)
end
