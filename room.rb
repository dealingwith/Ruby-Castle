class Room
  def initialize(thing)
    @thing = thing
    @thing_map = {
      "O" => "Ogre",
      "B" => "Blob",
      "D" => "Dragon",
    }
  end

  def do_room_action()
    if (@thing == "O" || @thing == "B" || @thing == "D")
      monster = @thing_map[@thing]
      puts "There's an #{monster} here!"
      monster = Object.const_get(monster).new()
      return do_battle(monster)
    else
      puts "There's not a Ogre, Blog, or Dragon here! So I don't know what to tell you yet."
    end
    return true
  end

  def do_battle(monster)
    puts "You are doing battle with a #{monster.class} named #{monster.name}!"
    puts "It has #{monster.health} health and a #{monster.attack} level attack."
    puts "You have 10 health and a 3 level attack."
    puts "You can attack or run away."
    playerhealth = 10
    playerattack = 3
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
          playerhealth -= monsterattackdamage
          if (monsterattackdamage == 0)
            puts "The #{monster.class} misses!"
          else
            puts "You take #{monsterattackdamage} damage! You have #{playerhealth} health left."
          end
          if (playerhealth <= 0)
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