class Game
  def initialize(player)
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
    @levels = []
    @player = player
  end

  def print_level(level)
    puts ""
    @levels[level].each do |level_row|
      puts level_row.join(" ")
    end
    puts ""
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
    return level
  end

  def make_map()
    (0..9).each do |n|
      @levels << make_level()
    end
  end

  def set_token_at_current_player_position(token)
    @levels[@player.z_position][@player.x_position][@player.y_position] = token
  end

  def token_at_current_player_position()
    @levels[@player.z_position][@player.x_position][@player.y_position]
  end

  def reposition_player()
    # get what was in that space
    @current_thing = token_at_current_player_position()
    # set that space to the player
    set_token_at_current_player_position("P".colorize(:blue))
  end

  def move_player()
    reposition_player()
    suspense()
    puts ""
    clear_and_prompt()
  end

  def thing_in_current_space()
    @things_map[@current_thing]
  end

  def clear_and_prompt()
    print_level(@player.z_position)
    puts "You're on level #{@player.z_position + 1}"
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
      elsif (result == "stairs")
        print_level(@player.z_position)
      end
    else
      puts "There's nothing here."
      set_token_at_current_player_position(" ")
    end
    prompt_for_direction()
  end

  def prompt_for_direction()
    puts "Where do you want to go? (w, a, s, d)"
    print '> '
  end
end
