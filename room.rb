class Room

  # "O" => "Ogre",
  # "W" => "Witch",
  # "B" => "Blob",
  # "D" => "Dragon",
  # "S" => "Stairs",
  # "C" => "Chest",
  # "H" => "Hole",
  # "R" => "Rat",
  # "M" => "Mushroom",
  # "P" => "A shadow of your past self!"

  def initialize(thing, thing_map, player)
    @thing = thing
    @thing_map = thing_map
    @player = player
  end

  def do_room_action()
    if (@player.is_hallucinating)
      puts "You see lots of colors and shapes. Weeee!".colorize(:light_green).on_black
    end
    if (["O", "B", "D", "R", "W"].include?(@thing))
      monster = @thing_map[@thing]
      monster = Object.const_get(monster).new()
      return do_battle(monster)
    elsif (@thing == "S") # stairs
      return stairs()
    elsif (@thing == "C")
      Chest.new(@player).open()
    elsif (@thing == "M")
      puts "You found a mushroom! Do you want to eat it?".colorize(:yellow)
      print '> '
      choice = STDIN.gets.chomp
      case choice
      when "y", "yes"
        puts "You eat the mushroom and feel..."
        suspense()
        @mushroom = Mushroom.new(@player)
        @mushroom.eat_mushroom()
      when "n", "no"
        puts "You leave the mushroom alone."
      end
    else
      puts "I don't know what to tell you yet."
    end
    if (@thing != "M" && @player.is_hallucinating)
      @player.random_sobriety()
    end
    return true
  end

  def do_battle(monster)
    puts "You are doing battle with a #{monster.class} named #{monster.name}!".colorize(:red)
    puts "It has #{monster.health} health and a #{monster.attack} level attack.".colorize(:red)
    puts "You have #{@player.health} health and a #{@player.attack} level attack.".colorize(:blue)
    puts "You can attack or run away."
    playerattack = @player.attack
    while (monster.health > 0)
      print '> '
      choice = STDIN.gets.chomp
      case choice
      when "a", "attack"
        playerattackdamage = rand(playerattack)
        monster.health -= playerattackdamage
        puts "You attack the #{monster.class}!"
        if (playerattackdamage == 0)
          puts "You miss!".colorize(:red)
        else
          puts "You deal #{playerattackdamage} damage!".colorize(:red)
        end
        if (monster.health <= 0)
          puts "You killed the #{monster.class}!".colorize(:blue)
          return true
        else
          puts "The #{monster.class} has #{monster.health} health left."
          sleep 0.3
          puts "The #{monster.class} attacks you!"
          monsterattackdamage = rand(monster.attack)
          @player.health -= monsterattackdamage
          if (monsterattackdamage == 0)
            puts "The #{monster.class} misses!".colorize(:yellow)
          else
            puts "You take #{monsterattackdamage} damage! You have #{@player.health} health left.".colorize(:yellow)
          end
          if (@player.health <= 0)
            puts "You died!".colorize(:red)
            return false
          end
        end
      when "r", "run", "run away"
        puts "You run away!"
        return "ran away"
      else
        puts "I don't understand that command."
      end
    end
  end

  def stairs()
    x = @player.x_position
    y = @player.y_position
    z = @player.z_position
    return true if (x == 9 && y == 9 && z == 0)
    # if player is at 9,9, they can only go down
    if (x == 9 && y == 9)
      if (prompt_for_action("Go down? (y/n)") == "y")
        if ((z - 1) < 0)
          puts "You can't go down any lower."
        else
          @player.set_position(0, 0, z - 1)
          puts "You go down a level."
          # print_level(@player.z_position)
          # reposition_player()
        end
      end
    # if player is at 0,0, they can only go up
    elsif (x == 0 && x == 0)
      if (prompt_for_action("Go up? (y/n)") == "y")
        if ((z + 1) > 9)
          puts "You can't go up any higher."
        else
          @player.set_position(9, 9, z + 1)
          puts "You go up a level."
          # print_level(@player.z_position)
          # reposition_player()
        end
      end
    end
    return "stairs"
  end
end
