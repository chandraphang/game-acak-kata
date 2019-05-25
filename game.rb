class Game
  WORDS = {
    '1' => 'buku',
    '2' => 'roti',
    '3' => 'topi',
    '4' => 'bunga',
    '5' => 'asbak',
    '6' => 'amplop',
    '7' => 'gerobak',
    '8' => 'senjata',
    '9' => 'laptop',
    '10' => 'komputer'
  }.freeze

  def initialize
    @leader_board = []

    print_welcome_words
  end

  def print_welcome_words
    system('clear')

    puts 'Selamat datang di Game Acak Kata'
    puts '================================'
    puts
  end

  def select_option
    puts 'Pilih Angka yang anda inginkan'
    puts '1. Bermain'
    puts '2. Melihat Papan Skor'
    puts '3. Keluar'

    print 'Masukkan angka:'
    gets.chomp
  end

  def print_leader_board
    if @leader_board.length.zero?
      puts 'Data masih kosong'
    else
      puts '========================='
      @leader_board.each_with_index do |line, index|
        puts "#{index+1}. #{line.first}: #{line.last}"
      end
      puts '========================='
    end
    puts
  end

  def print_summary
    puts "Sisa Pertanyaan: #{WORDS.length - @point}"
    puts "Point          : #{@point}"
    puts "Kesempatan     : #{@chance}"
    puts "-------------------"
  end

  def play
    system('clear')
    player_name  = create_new_session
    random_words = randomize_words 

    random_words.each do |key, word|
      print_summary
      puts "Tebak kata: #{word}"
      print 'Jawab:'
      user_input = gets.chomp

      if user_input == WORDS[key]
        processing_true_answer
      elsif @chance.zero?
        print_last_attempt
        break
      else
        processing_wrong_answer
        redo
      end
    end

    save_data(player_name)
  end

  def create_new_session
    @point  = 0
    @chance = 3

    print 'Masukkan Nama Anda:'
    gets.chomp
  end

  def randomize_words
    # this is hash order randomizer
    random_hash = Hash[WORDS.to_a.sample(WORDS.length)]

    # this is word randomizer
    random_hash.map do |key, word|
      [key, word.split("").shuffle.join]
    end.to_h
  end

  def processing_true_answer
    @point += 1
    puts "BENAR point anda: #{@point}!"

    if WORDS.length == @point
      puts "SELAMAT! Anda telah menjawab #{@point} pertanyaan dengan BENAR"
      gets.chomp
    end
    system('clear')
  end

  def print_last_attempt
    puts "SELAMAT! Anda telah menjawab #{@point} pertanyaan dengan BENAR"
    gets.chomp
  end

  def processing_wrong_answer
    @chance -= 1
    puts "SALAH! Silahkan coba lagi"
    puts
  end

  def save_data(name)
    @leader_board << [name, @point]
    @leader_board = @leader_board.sort_by(&:last).reverse
  end
end

begin
  game    = Game.new
  option  = game.select_option

  loop do
    if ['1', '2', '3'].include?(option)
      case(option)
      when '1'
        game.play
      when '2'
        game.print_leader_board
      when '3'
        puts
        puts 'Anda Telah Keluar Dari Game'
        exit
      end
    else
      system('clear')
      puts 'Input tidak valid'
      puts
    end

    option = game.select_option
  end
# this rescue is to prevent error messages from sudden exit from program
# so the program will closed smoothly
rescue NoMethodError
  puts
  puts
  puts 'Anda Telah Keluar Dari Game'
end