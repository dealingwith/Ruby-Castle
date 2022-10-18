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
end
