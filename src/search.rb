class Search
  def initialize(cardFile)
    @list = []
    cards = JSON.parse(File.read(cardFile).force_encoding("utf-8"))

    cards.each do |card|
      @list << card["name"].downcase
    end
  end

  def buildAutocomplete
    @list.sort!
    comp = proc { |s| @list.grep(/^#{Regexp.escape(s)}/) }
    Readline.completion_append_character = ""
    Readline.completion_proc = comp
  end

  def initParser
    # Start a parser that takes a card argument, displays the card and exits
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: #{$PROGRAM_NAME} [options]"
      opts.on('-c n', '--card=n', 'Card name') do |c|
        c.gsub!(' ', '%20')
        card = Card.new(c)
        card.display
        exit
      end
    end
    parser.parse!
  end

  def initReadline
    # Start reading the lines and when a name is entered, do a search
    begin
      while line = Readline.readline('> ', true)
        line.gsub!(' ', '%20')
        card = Card.new(line)
        card.display
      end
    rescue Interrupt => e
      system('stty', `stty -g`.chomp) # Restore
      exit
    end
  end
end
