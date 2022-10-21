require 'awesome_print'
require 'io/console'
require 'colorize' # https://github.com/fazibear/colorize
require 'whirly' # https://github.com/janlelis/whirly
require 'paint'
require './player'
require './monster'
require './room'
require './mushroom'
require './chest'
require './game'

def suspense(prompt="Suspense...")
  Whirly.start spinner: "simpleDotsScrolling", color: false, status: prompt do
    sleep 1.5
  end
end

def prompt_for_action(prompt_string)
  puts prompt_string
  print '> '
  return $stdin.gets.chomp
end

# Let the game begin
name = prompt_for_action("What is your name?")
player = Player.new(name)
game = Game.new(player)
puts "Welcome to the dungeon, #{player.name}!".colorize(:blue)
puts "Your health is #{player.health} and your attack is #{player.attack}".colorize(:yellow)

game.make_map()
game.reposition_player()
game.clear_and_prompt()

loop do
  direction = STDIN.gets.chomp
  case direction
  when "w"
    if player.x_position - 1 >= 0
      player.x_position -= 1
      puts "You walk through the door to the north."
      game.move_player()
    else
      puts "You can't go that way."
    end
  when "a"
    if player.y_position - 1 >= 0
      player.y_position -= 1
      puts "You walk through the door to the west."
      game.move_player()
    else
      puts "You can't go that way."
    end
  when "s"
    if player.x_position + 1 < 10
      player.x_position += 1
      puts "You walk through the door to the south."
      game.move_player()
    else
      puts "You can't go that way."
    end
  when "d"
    if player.y_position + 1 < 10
      player.y_position += 1
      puts "You walk through the door to the east."
      game.move_player()
    else
      puts "You can't go that way."
    end
  when "q"
    exit
  when "map", "m"
    game.print_level(player.z_position)
    game.prompt_for_direction()
  when "help"
    puts "w, a, s, d to move"
    puts "q to quit"
    puts "map to see the map"
  when "ds" # debug stairs
    player.set_position(0, 0, player.z_position)
    game.move_player()
  else
    puts "I don't know what you mean."
    print '> '
  end
end
