class Player
  attr_accessor :name, :health, :attack, :is_hallucinating, :x_position, :y_position, :z_position

  def initialize(name)
    @name = name
    @health = rand(8..12)
    @attack = rand(2..4)
    @is_hallucinating = false
    @x_position = 9
    @y_position = 9
    @z_position = 0
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

  def set_position(x, y, z)
    @x_position = x
    @y_position = y
    @z_position = z
  end
end
