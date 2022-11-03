class Map
  def initialize()
    @levels = []
    @things = [
      'O', 'W', 'B', 'D', 'C', 'H', 'R', 'M'
    ]
    make_map()
  end

  def get_level(level)
    @levels[level]
  end

  def set_current_player_xy_position(player)
    @player_position = [player.x_position, player.y_position]
  end

  def set_token_at_current_player_position(player, token)
    @levels[player.z_position][player.x_position][player.y_position] = token
  end

  def token_at_current_player_position(player)
    @levels[player.z_position][player.x_position][player.y_position]
  end

  def print_level(level)
    puts ""

    @levels[level].each_with_index do |level_row, x_index|
      # one row of the level
      level_row.each_with_index do |level_cell, y_index|
        # one cell of the level
        if (x_index == @player_position[0] && y_index == @player_position[1])
          # puts "printing the player token!"
          print "P".colorize(:blue)
        else
          print level_cell
        end
        print " "
      end

      puts ""
    end

    puts ""
  end

  def make_map()
    (0..9).each do |n|
      @levels << make_level()
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
    return level
  end
end
