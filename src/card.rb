class Card
  def initialize(card)
    @card = card
  end

  def getRarity
    case @card["rarity"]
      when "Free" then "Free".colorize(:light_black)
      when "Common" then "Common".colorize(:white)
      when "Rare" then "Rare".colorize(:light_blue)
      when "Epic" then "Epic".colorize(:magenta)
      when "Legendary" then "Legendary".colorize(:yellow)
    end
  end

  def getPlayerClass
    case @card["playerClass"]
      when "Priest" then "Priest".colorize(:white)
      when "Druid" then "Druid".colorize(:light_green)
      when "Mage" then "Mage".colorize(:light_blue)
      when "Shaman" then "Shaman".colorize(:blue)
      when "Paladin" then "Paladin".colorize(:yellow)
      when "Warlock" then "Warlock".colorize(:magenta)
      when "Hunter" then "Hunter".colorize(:green)
      when "Rogue" then "Rogue".colorize(:yellow)
      when "Warrior" then "Warrior".colorize(:red)
    end
  end

  def cleanText(text)
    return "" if text.nil?
    text.gsub!(/\<\/*[ib]\>/, "")
    text
  end

  def display
    type = @card['type']
    # Enchantments aren't cards
    return if type == "Enchantment"
    rows = []
    rows << ['Name', @card['name']]
    rows << ['Cost'.colorize(:yellow), @card['cost']]
    rows << ['Attack'.colorize(:red), @card['attack']] if type == "Minion"
    rows << ['Health'.colorize(:green), @card['health']] if type == "Minion"
    rows << ['Durability'.colorize(:green), @card['durability']] if type == "Weapon"
    rows << ['Quality', getRarity()]
    rows << ['Class', getPlayerClass()] unless @card['playerClass'].nil?
    rows << ['Type', type]
    rows << ['Set', @card['set']] unless @card['set'].nil?
    rows << ['Race', @card['race']] unless @card['race'].nil?
    rows << ['Text', cleanText(@card['text'])] unless @card['text'].nil?
    rows << ['Flavor', cleanText(@card['flavor'])] unless @card['flavor'].nil?
    table = Terminal::Table.new :rows => rows
    puts table
  end
end
