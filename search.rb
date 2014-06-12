require 'readline'
require 'open-uri'
require 'json'
require 'terminal-table'
require 'colorize'

# Grab all cards and store them for autocomplete. This should perhaps be stored locally.
list = []
cards = JSON.parse(File.read('card-names.json'))

cards.each do |card|
  list << card["name"].downcase
end

list = list.sort

comp = proc { |s| list.grep(/^#{Regexp.escape(s)}/) }

Readline.completion_append_character = ""
Readline.completion_proc = comp

# When a name has been searched, send a request and start parsing.
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
    when 0 then "Free".colorize(:light_black)
    when 1 then "Common".colorize(:white)
    when 3 then "Rare".colorize(:light_blue)
    when 4 then "Epic".colorize(:magenta)
    when 5 then "Legendary".colorize(:yellow)
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

  race = case card["race"].to_i
    when 14 then "Murloc"
    when 15 then "Demon"
    when 20 then "Beast"
    when 21 then "Totem"
    when 23 then "Pirate"
    when 24 then "Dragon"
    else "Neutral"
  end

  rows = []
  rows << ['Name', card['name']]
  rows << ['Cost'.colorize(:yellow), card['cost']]
  rows << ['Attack'.colorize(:red), card['attack']] if type == "Minion"
  rows << ['Health'.colorize(:green), card['health']] if type == "Minion"
  rows << ['Quality', quality.colorize(:orange)]
  rows << ['Type', type]
  rows << ['Set', set]
  rows << ['Race', race]
  rows << ['Description', card['description']]
  table = Terminal::Table.new :rows => rows
  p table
end
