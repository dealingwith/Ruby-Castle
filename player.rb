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
    @exclamations = [
      "You see lots of colors and shapes. Weeee!",
      "I can smell the future!",
      "I can see stars!",
      "This cobblestone looks like purple bread...",
      "That rat I fought was pretty edible...",
      "Do the holes go to outer space?",
      "On my way to the stairway to heaven!"
    ]
  end

  def sober_up()
    if (@is_hallucinating)
      @is_hallucinating = false
      puts "You feel too sober.".colorize(:light_green).on_black
    end
  end

  def random_sobriety()
    if (rand < 0.7)
      puts "Things still feel a little weird.".colorize(:light_green).on_black
    else
      sober_up()
    end
  end

  def set_position(x, y, z)
    @x_position = x
    @y_position = y
    @z_position = z
  end

  def hallucinate()
    puts "You randomly exclaim, " + "\"#{@exclamations.sample}\"".colorize(:light_green).on_black if @is_hallucinating && rand(0..2).odd?
  end
end
