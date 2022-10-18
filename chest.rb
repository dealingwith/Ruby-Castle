class Chest
  def initialize(player)
    @player = player
    @chest_contents = ['health potion', 'a better sword']
  end

  def open
    puts "You found a chest! You open it, natch!".colorize(:blue)
    @chest_contents = ['a cola', 'lizard'] if (@player.is_hallucinating)
    randomthing_index = rand(@chest_contents.length)
    puts "You found a #{@chest_contents[randomthing_index]}!".colorize(:yellow)
    if (randomthing_index == 0)
      puts "It kind of tastes like a potion." if (@player.is_hallucinating)
      puts "You drink it and feel better!".colorize(:blue)
      @player.health += 5
      puts "You now have #{@player.health} health.".colorize(:yellow)
      @player.sober_up()
    elsif (randomthing_index == 1)
      if (@player.is_hallucinating)
        if (rand < 0.5)
          puts "It's a scary #{@chest_contents[randomthing_index]}!".colorize(:red)
          puts "You drop the #{@chest_contents[randomthing_index]} and run away!".colorize(:red)
          return true
        else
          puts "You look contemplatively at the #{@chest_contents[randomthing_index]}.".colorize(:blue)
          puts "You decide to keep it.".colorize(:blue)
        end
      end
      @player.attack += 1
      puts "Your attack is now #{@player.attack}".colorize(:yellow)
    end
  end
end
