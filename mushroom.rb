class Mushroom
  def initialize(player)
    @player = player
  end

  def eat_mushroom()
    if (rand < 0.2)
      puts "great!"
      @player.health += rand(1..5)
      puts "You now have #{@player.health} health."
      @player.sober_up()
    elsif (rand < 0.8)
      # You hallucinate
      puts "straaaaange..."
      @player.is_hallucinating = true
    else
      puts "terrible! It was a poisonous mushroom!"
      @player.health -= rand(1..5)
      puts "You now have #{@player.health} health."
    end
  end
end
