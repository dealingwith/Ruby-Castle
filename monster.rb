class Monster
  attr_accessor :name, :health, :attack

  def initialize(name=nil, health, attack)
    @name = name || ["Bill", "Suzie", "Bob", "Sally", "Fred"].sample
    @health = health
    @attack = attack
  end
end

class Ogre < Monster
  def initialize 
    super("Oscar", rand(5..10), rand(2..4))
  end
end

class Blob < Monster
  def initialize
    super("Blobby", rand(1..5), rand(1..2))
  end
end

class Dragon < Monster
  def initialize
    super("Toothless", rand(10..20), rand(5..15))
  end
end
