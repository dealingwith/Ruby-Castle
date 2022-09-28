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
    ogre_names = ["Oscar", "Jed", "Gerald", "Geraldine", "Oggy"].sample
    super(ogre_names, rand(5..10), rand(2..4))
  end
end

class Blob < Monster
  def initialize
    blob_names = ["Bert", "Blobby", "Mister", "Big Ernie", "Bertie"].sample
    super(blob_names, rand(1..5), rand(1..2))
  end
end

class Dragon < Monster
  def initialize
    dragon_names = ["Toothless", "Smaug", "Saphira", "Eragon", "Saphira"].sample
    super(dragon_names, rand(10..20), rand(5..15))
  end
end

class Rat < Monster
  def initialize
    rat_names = ["Ratty", "Rat", "Ratty McRatface", "Ratman", "Ratwoman"].sample
    super(rat_names, rand(1..5), rand(1..2))
  end
end

class Witch < Monster
  def initialize
    witch_names = ["Rae", "Keon", "Amber", "Kitty", "Leonora"].sample
    super(witch_names, rand(5..10), rand(2..4))
  end
end
