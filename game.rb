class Game
  def initialize(player)
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
    @map = Map.new()
    @current_thing = " "
    @player = player
  end

  def reposition_player()
    # get what was in that space
    @current_thing = @map.token_at_current_player_position(@player)
    # tell the map where the player is on this level
    @map.set_current_player_xy_position(@player)
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

  def debug_message(message)
    puts "----"
    puts "DEBUG: #{message}".colorize(:light_blue)
    puts "----"
  end

  def clear_and_prompt()
    # occassionally, the player will hallucinate (if they be trippin') (randomness handled in player.haluclinate)
    @player.hallucinate()
    @map.print_level(@player.z_position)
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
        @map.set_token_at_current_player_position(@player, @current_thing)
      elsif (result == true)
        @map.set_token_at_current_player_position(@player, " ")
      elsif (result == "stairs")
        reposition_player()
        @map.print_level(@player.z_position)
      end
    else
      puts "There's nothing here."
      @map.set_token_at_current_player_position(@player, " ")
    end
    prompt_for_direction()
  end

  def prompt_for_direction()
    puts "Where do you want to go? (w, a, s, d)"
    print '> '
  end
end
