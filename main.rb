# castle

require 'awesome_print'
require 'io/console'
require 'colorize' # https://github.com/fazibear/colorize
require './player'
require './monster'
require './room'
require './mushroom'
require './chest'

# things = ("a".."z").to_a
@things = [
  'O', 'W', 'B', 'D', 'C', 'H', 'R', 'M'
]
@things_map = {
  "O" => "Ogre",
  "W" => "Witch",
  "B" => "Blob",
  "D" => "Dragon",
  "S" => "Stairs",
  "C" => "Chest",
  "H" => "Hole",
  "R" => "Rat",
  "M" => "Mushroom",
  "P" => "A shadow of your past self!"
}
@current_thing = " "

def print_level(level)
  level.each do |level_row|
    puts level_row.join(" ")
  end
end

def make_level()
  # make a single level
  # an array of arrays
  # 8 x 8
  level = []
  (0..9).each do |n|
    level << []
  end

  level.each do |level_row|
    # one row of the level
    (0..9).each do |n|
      if rand < 0.60
        level_row << @things.sample
      else
        level_row << " "
      end
    end
  end
  level[0][0] = "S"
  level[9][9] = "S"
  level
end

def make_map()
  (0..9).each do |n|
    @levels << make_level()
  end
end

def set_token_at_current_player_position(token)
  @levels[@player_position[2]][@player_position[0]][@player_position[1]] = token
end

def token_at_current_player_position()
  @levels[@player_position[2]][@player_position[0]][@player_position[1]]
end

def reposition_player()
  # get what was in that space
  @current_thing = token_at_current_player_position()
  # set that space to the player
  set_token_at_current_player_position("P".colorize(:blue))
end

def suspense()
  (0..2).each do |n|
    sleep 0.25
    print "."
  end
end

def move_player()
  reposition_player()
  suspense()
  print "\n"
  clear_and_prompt()
end

def thing_in_current_space()
  @things_map[@current_thing]
end

def clear_and_prompt()
  print_level(@levels[@player_position[2]])
  puts "\n"
  puts "You're on level #{@player_position[2] + 1}"
  if (@current_thing != " ")
    puts "You see a #{thing_in_current_space()}".colorize(:yellow)
    room = Room.new(@current_thing, @things_map, @player)
    result = room.do_room_action()
    if (result == false)
      puts "GAME OVER".colorize(:red)
      exit
    elsif (result == "ran away")
      # do nothing
      set_token_at_current_player_position(@current_thing)
    elsif (result == true)
      set_token_at_current_player_position(" ")
    end
  else
    puts "There's nothing here."
    set_token_at_current_player_position(" ")
  end
  prompt_for_direction()
end

def prompt_for_action(prompt_string)
  puts prompt_string
  print '> '
  $stdin.gets.chomp
end

def prompt_for_direction()
  puts "Where do you want to go? (w, a, s, d)"
  # puts "Or you can go up or down a level (u, d)" if (@current_thing == "S")
  print '> '
end

@levels = []
@player_position = [9, 9, 0] # x, y, z ---- I should consider y, x, z because that would be easier to use inside of reposition_player()

make_map()
reposition_player()

name = prompt_for_action("What is your name?")
@player = Player.new(name)
puts "Welcome to the dungeon, #{@player.name}!".colorize(:blue)
puts "Your health is #{@player.health} and your attack is #{@player.attack}"

clear_and_prompt()

loop do
  direction = STDIN.gets.chomp
  case direction
  when "w"
    if @player_position[0] - 1 >= 0
      @player_position[0] -= 1
      puts "You walk through the door to the north."
      move_player()
    else
      puts "You can't go that way."
    end
  when "a"
    if @player_position[1] - 1 >= 0
      @player_position[1] -= 1
      puts "You walk through the door to the west."
      move_player()
    else
      puts "You can't go that way."
    end
  when "s"
    if @player_position[0] + 1 < 10
      @player_position[0] += 1
      puts "You walk through the door to the south."
      move_player()
    else
      puts "You can't go that way."
    end
  when "d"
    if @player_position[1] + 1 < 10
      @player_position[1] += 1
      puts "You walk through the door to the east."
      move_player()
    else
      puts "You can't go that way."
    end
  when "q"
    exit
  when "map"
    print_level(@levels[@player_position[2]])
  when "help"
    puts "w, a, s, d to move"
    # puts "u to go up a level"
    # puts "d to go down a level"
    puts "q to quit"
    puts "map to see the map"
  else
    puts "I don't know what you mean."
    print '> '
  end
end
