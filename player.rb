class Player
  attr_accessor :name, :health, :attack, :is_hallucinating

  def initialize(name)
    @name = name
    @health = 10
    @attack = rand(2..4)
    @is_hallucinating = false
  end
end
