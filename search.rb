require 'readline'
require 'open-uri'
require 'json'


LIST = [
  'search', 'download', 'open',
  'help', 'history', 'quit',
  'url', 'next', 'clear',
  'prev', 'past'
].sort

# comp = proc { |s| LIST.grep(/^#{Regexp.escape(s)}/) }

# Readline.completion_append_character = " "
# Readline.completion_proc = comp

# while line = Readline.readline('> ', true)
#   p line
# end

list = []
str = ""
open("http://hearthstoneapi.com/cards/findAll") {|f| str = f.read }
cards = JSON.parse(str)

cards.each do |card|
  list << card["name"].downcase
end


list = list.sort


comp = proc { |s| list.grep(/^#{Regexp.escape(s)}/) }

Readline.completion_append_character = ""
Readline.completion_proc = comp

while line = Readline.readline('> ', true)
  line.gsub!(' ', '%20')
  card = ""
  open("http://hearthstoneapi.com/cards/name/"+line) {|f| card = JSON.parse(f.read) }
  card = card[0]

  set = case card["set"].to_i
    when 2 then "Basic"
    when 3 then "Expert"
    when 4 then "Reward"
    when 5 then "Missions"
    when 11 then "Promotion"
  end

  quality = case card["quality"].to_i
    when 0 then "Free"
    when 1 then "Common"
    when 3 then "Rare"
    when 4 then "Epic"
    when 5 then "Legendary"
  end

  type = case card["type"].to_i
    when 4 then "Minion"
    when 5 then "Spell"
    when 7 then "Weapon"
  end

  clss = case card["class"].to_i
    when 1 then "Warrior"
    when 2 then "Paladin"
    when 3 then "Hunter"
    when 4 then "Rogue"
    when 5 then "Priest"
    when 7 then "Shaman"
    when 8 then "Mage"
    when 9 then "Warlock"
    when 11 then "Druid"
    else "Neutral"
  end

  p card["name"].green
  p clss + " " + quality + " " + set + " " + type + " card."




end



class String
def black;          "\033[30m#{self}\033[0m" end
def red;            "\033[31m#{self}\033[0m" end
def green;          "\033[32m#{self}\033[0m" end
def brown;          "\033[33m#{self}\033[0m" end
def blue;           "\033[34m#{self}\033[0m" end
def magenta;        "\033[35m#{self}\033[0m" end
def cyan;           "\033[36m#{self}\033[0m" end
def gray;           "\033[37m#{self}\033[0m" end
def bg_black;       "\033[40m#{self}\033[0m" end
def bg_red;         "\033[41m#{self}\033[0m" end
def bg_green;       "\033[42m#{self}\033[0m" end
def bg_brown;       "\033[43m#{self}\033[0m" end
def bg_blue;        "\033[44m#{self}\033[0m" end
def bg_magenta;     "\033[45m#{self}\033[0m" end
def bg_cyan;        "\033[46m#{self}\033[0m" end
def bg_gray;        "\033[47m#{self}\033[0m" end
def bold;           "\033[1m#{self}\033[22m" end
def reverse_color;  "\033[7m#{self}\033[27m" end
end


# [
#   {
#     "set": 3,
#     "type": 5,
#     "faction": 3,
#     "classs": 4,
#     "quality": 4,
#     "cost": 0,
#     "name": "Preparation",
#     "description": "The next spell you cast this turn costs (3) less.",
#     "createdAt": "2014-04-10T18:25:18.995Z",
#     "updatedAt": "2014-04-10T18:25:18.995Z",
#     "id": 215
#   }
# ]
