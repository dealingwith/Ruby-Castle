class Player
  attr_accessor :name, :health, :attack

  def initialize(name)
    @name = name
    @health = 10
    @attack = rand(2..4)
  end
end
