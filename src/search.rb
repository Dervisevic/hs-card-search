class Search
  def initialize()
    @sets  = JSON.parse(File.read(File.join(File.dirname(__FILE__), '..', 'data', 'sets.json')).force_encoding("utf-8"))
    @cards = JSON.parse(File.read(File.join(File.dirname(__FILE__), '..', 'data', 'cards.json')).force_encoding("utf-8"))
    # There are a bunch of "cards" in the set from missions, like mukla's brother, reject these.
    @sets.reject! { |set| ["Credits", "Debug", "Missions", "System"].include?(set)  }
  end

  def buildAutocomplete
    list = []
    @sets.each do |set|
      @cards[set].each do |card|
        list << card["name"].downcase
      end
    end
    list.sort!
    comp = proc { |s| list.grep(/^#{Regexp.escape(s)}/) }
    Readline.completion_append_character = ""
    Readline.completion_proc = comp
  end

  def initParser
    # Start a parser that takes a card argument, displays the card and exits
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: #{$PROGRAM_NAME} [options]"
      opts.on('-c n', '--card=n', 'Card name') do |c|
        cards = search(c, "name")
        cards.each do |card|
          card_obj = Card.new(card)
          card_obj.display
        end
        exit
      end
    end
    parser.parse!
  end

  def search(term, key)
    return [] if term.empty?
    @cards_found = []
    @sets.each do |set|
      found = @cards[set].select {|card| card[key].downcase.include? term.downcase }
      found.each do |card|
        card['set'] = set
      end
      @cards_found = @cards_found | found unless found.empty?
    end
    @cards_found
  end

  def initReadline
    # Start reading the lines and when a name is entered, do a search
    begin
      while line = Readline.readline('> ', true)
        cards = search(line, "name")
        cards.each do |card|
          card_obj = Card.new(card)
          card_obj.display
        end
      end
    rescue Interrupt => e
      system('stty', `stty -g`.chomp) # Restore
      exit
    end
  end
end
