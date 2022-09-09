class Monster
  attr_accessor :name, :health, :attack

  def initialize(name=nil, health, attack)
    @name = name || ["Bill", "Suzie", "Bob", "Sally", "Fred"].sample
    @health = health
    @attack = attack
  end
end

class Ogre < Monster

end