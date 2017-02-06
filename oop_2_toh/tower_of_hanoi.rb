require_relative 'rod.rb'
require_relative 'disk.rb'

class TowerOfHanoi
  def initialize(disks=3)
    @rod_one = Rod.new
    @rod_two = Rod.new
    @rod_three = Rod.new

    disks.downto(1) do |i|
      @rod_one.add_disk(Disk.new(i))
    end
  end

  # TODO - Refactor new_game method
  def new_game
    reset_board
    instructions
    render
  end

  def reset_board
    @rod_one.reset
    @rod_two.reset
    @rod_three.reset
  end

  def instructions
    puts "\nWelcome to Tower of Hanoi!\n\n"
    puts "Instructions:\n\n"
    puts "Enter where you'd like to move from and to"
    puts "in the format '1,3'. Enter 'q' to quit."
  end

  # TODO - Refactor move_disk method
  def move_disk(entry)
    from = entry[0].to_i - 1
    to = entry[2].to_i - 1

    # disk = @rods[from].pop()
    # @rods[to].push(disk)
  end

  # TODO - Refactor win? method
  def win?
    winning_sequence = []

    @disks.downto(1) do |i|
      winning_sequence.push(i)
    end

    @rods[1] == winning_sequence || @rods[2] == winning_sequence ? true : false
  end

  def invalid_entry
    puts "Please enter a valid input."
  end

  def play_again?
    puts "Congratulations! Would you like to play again?"
    puts "Enter 'y' to play again or 'q' to quit."
    entry = gets.chomp()

    if entry == "q"
      return false
    elsif entry == "y"
      return true
    else
      invalid_entry
      play_again?
    end
  end

  def quit?(entry)
    entry == "q"
  end

  # TODO - Refactor play method
  def play
    new_game

    until win?
      user_move
      render
    end

    play_again? ? play : exit
  end

  # TODO - Refactor render methods
  #### Render methods
  def render
    puts "Rod One:"
    @rod_one.render
    puts "Rod Two:"
    @rod_two.render
    puts "Rod Three:"
    @rod_three.render
  end

  # TODO - Refactor valid_move? method
  def valid_move?(entry)
    from = entry[0].to_i - 1
    to = entry[2].to_i - 1

    return false unless /[1-3,1-3]/.match(entry)
    return false if from == to
    return false if @rods[from] == []

    if @rods[to] != []
      return false if @rods[to][-1] < @rods[from][-1]
    end

    true
  end

  # TODO - Refactor user_move method
  def user_move
    print "Enter move: "
    entry = gets.chomp()

    if quit?(entry)
      exit
    elsif valid_move?(entry)
      move_disk(entry)
    else
      invalid_entry
      user_move
    end
  end

end

a = TowerOfHanoi.new
a.render