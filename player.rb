class Player
  attr_accessor :name, :health, :attack, :is_hallucinating

  def initialize(name)
    @name = name
    @health = 10
    @attack = rand(2..4)
    @is_hallucinating = false
  end

  def sober_up()
    if (@is_hallucinating)
      @is_hallucinating = false
      puts "You feel too sober."
    end
  end

  def random_sobriety()
    if (rand < 0.7)
      puts "Things still feel a little weird."
    else
      sober_up()
    end
  end
end
