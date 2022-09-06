# castle

require "awesome_print"

def print_level(level)
  level.each do |level_row|
    puts level_row.join(" ")
  end
end

# make a single level
# an array of arrays
# 8 x 8
level = []
(0..8).each do |n|
  level << []
end
things = ('a'..'z').to_a

level.each do |level_row|
  # one row of the level
  (0..8).each do |n|
    level_row << things.sample
  end
end

# ap level
print_level level
