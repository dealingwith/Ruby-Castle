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
    if (["O", "B", "D", "R", "W"].include?(@thing))
      monster = @thing_map[@thing]
      monster = Object.const_get(monster).new()
      return do_battle(monster)
    elsif (@thing == "C")
      puts "You found a chest! You open it, natch!"
      randomthing = ["health potion", "a better sword"].sample
      puts "You found a #{randomthing}!"
      if (randomthing == "health potion")
        puts "You drink it and feel better!"
        @player.health += 5
        puts "You now have #{@player.health} health."
      elsif (randomthing == "a better sword")
        puts "You equip it and feel stronger!"
        @player.attack += 1
        puts "Your attack is now #{@player.attack}"
      end
    else
      puts "I don't know what to tell you yet."
    end
    return true
  end

  def do_battle(monster)
    puts "You are doing battle with a #{monster.class} named #{monster.name}!"
    puts "It has #{monster.health} health and a #{monster.attack} level attack."
    puts "You have #{@player.health} health and a #{@player.attack} level attack."
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
          puts "You miss!"
        else
          puts "You deal #{playerattackdamage} damage!"
        end
        if (monster.health <= 0)
          puts "You killed the #{monster.class}!"
          return true
        else
          puts "The #{monster.class} has #{monster.health} health left."
          sleep 0.3
          puts "The #{monster.class} attacks you!"
          monsterattackdamage = rand(monster.attack)
          @player.health -= monsterattackdamage
          if (monsterattackdamage == 0)
            puts "The #{monster.class} misses!"
          else
            puts "You take #{monsterattackdamage} damage! You have #{@player.health} health left."
          end
          if (@player.health <= 0)
            puts "You died!"
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