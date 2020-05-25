# notepad main
require_relative 'post.rb'
require_relative 'link.rb'
require_relative 'memo.rb'
require_relative 'task.rb'

puts "Hello! I'm your notepad!"
puts "What do you want to write in notepad?"

choices = Post.post_types

user_choice = -1

# infinite cycle until user make choice
while user_choice < 0 || user_choice >= (choices.size) do

  choices.each_with_index do |item, i|
    puts "\t#{i}. #{item}"
  end

  user_choice = STDIN.gets.to_i
end

# create an object of chosen type
entry = Post.create(user_choice)

entry.read_from_console
entry.save

puts "Huray! Note created!"