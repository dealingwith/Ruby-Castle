class Room
  def initialize(thing)
    @thing = thing
  end

  def do_room_action()
    if (@thing == "O")
      puts "There's an ogre here!"
      ogre = Ogre.new(nil, 10, 5)
      player_response = prompt_for_action("Do you want to fight it? (y/n)")
      if (player_response == "y")
        puts "You fight the ogre!"
        return self.do_battle(ogre)
      else
        puts "You run away!"
        return "ran away"
      end
    else
      puts "There's not an ogre here! So I don't know what to tell you yet."
    end
    return true
  end

  def do_battle(monster)
    puts "You are doing battle with a #{monster.class} named #{monster.name}!"
    puts "It has #{monster.health} health and a #{monster.attack} level attack."
    if (rand < 0.5)
      puts "You win!"
      return true
    else
      puts "You lose!"
      return false
    end
  end
end