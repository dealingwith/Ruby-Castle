# castle

require 'awesome_print'
require 'io/console'

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

def reposition_player()
  current_level = @levels[@player_position[2]] # the level the player is on
  @current_thing = current_level[@player_position[0]][@player_position[1]]
  current_level[@player_position[0]][@player_position[1]] = "P"
end

def move_player()
  reposition_player()
  # (0..3).each do |n|
  #   sleep 0.25
  #   print "."
  # end
  print "\n"
  clear_and_prompt()
end

def thing_in_current_space()
  @things_map[@current_thing]
end

def clear_and_prompt()
  # system "clear"
  print_level(@levels[@player_position[2]])
  puts "\n"
  puts "You're on level #{@player_position[2] + 1}"
  puts "You're at #{@player_position[0]}, #{@player_position[1]}"
  if (@current_thing != " ")
    puts "You see a #{thing_in_current_space()}"
  else
    puts "There's nothing here."
  end
  puts "Where do you want to go? (w, a, s, d)"
  puts "Or you can go up or down a level (u, d)" if (@current_thing == "S")
  print '> '
end

@levels = []
@player_position = [9, 9, 0] # x, y, z ---- I should consider y, x, z because that would be easier to use inside of reposition_player()

make_map()
reposition_player()
clear_and_prompt()

loop do
  direction = STDIN.getch.chomp
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
  else
    puts "I don't know what you mean."
    print '> '
  end
end


# ap levels
# levels.each do |level|
#   puts "Level #{levels.index(level)}"
#   print_level(level)
# end

