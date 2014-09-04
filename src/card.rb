class Card
  def initialize(name)
  card = ""
  open("http://hearthstoneapi.com/cards/name/"+name) {|f| card = JSON.parse(f.read) }
  @card = card[0]
  end

  def getSet
    case @card["set"].to_i
      when 2 then "Basic"
      when 3 then "Expert"
      when 4 then "Reward"
      when 5 then "Missions"
      when 11 then "Promotion"
    end
  end

  def getQuality
    case @card["quality"].to_i
      when 0 then "Free".colorize(:light_black)
      when 1 then "Common".colorize(:white)
      when 3 then "Rare".colorize(:light_blue)
      when 4 then "Epic".colorize(:magenta)
      when 5 then "Legendary".colorize(:yellow)
    end
  end

  def getType
    case @card["type"].to_i
      when 4 then "Minion"
      when 5 then "Spell"
      when 7 then "Weapon"
    end
  end

  def getClass
    case @card["class"].to_i
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
  end

  def getRace
    case @card["race"].to_i
      when 14 then "Murloc"
      when 15 then "Demon"
      when 20 then "Beast"
      when 21 then "Totem"
      when 23 then "Pirate"
      when 24 then "Dragon"
      else "Neutral"
    end
  end

  def display
    begin
      type = getType()
    rescue
      puts "Card not found".colorize(:red)
      exit
    end
    rows = []
    rows << ['Name', @card['name']]
    rows << ['Cost'.colorize(:yellow), @card['cost']]
    rows << ['Attack'.colorize(:red), @card['attack']] if type == "Minion"
    rows << ['Health'.colorize(:green), @card['health']] if type == "Minion"
    rows << ['Quality', getQuality().colorize(:orange)]
    rows << ['Type', type]
    rows << ['Set', getSet()]
    rows << ['Race', getRace()]
    rows << ['Description', @card['description']]
    table = Terminal::Table.new :rows => rows
    puts table
  end
end
