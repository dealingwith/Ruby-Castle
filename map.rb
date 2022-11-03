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

  def set_current_player_position(player)
    # TODO
  end

  def set_token_at_current_player_position(player, token)
    @levels[player.z_position][player.x_position][player.y_position] = token
  end

  def token_at_current_player_position(player)
    @levels[player.z_position][player.x_position][player.y_position]
  end

  def print_level(level)
    puts ""
    @levels[level].each do |level_row|
      puts level_row.join(" ")
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
