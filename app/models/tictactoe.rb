class Tictactoe
  attr_accessor :board, :message

  def initialize
    @board  = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    @user   = 1
    @server = 2
    @game_ended = false
  end

  def start
    if coin_toss == @server
      @message = "Bienvenido, el servidor ha ganado el lanzamiento de moneda y obtiene el primer turno."
      server_turn()
    else
      @message = "Bienvenido, has ganado el lanzamiento de moneda y obtienes el primer turno."
    end
  end

  def coin_toss
    return 1 + rand(2)
  end

  def server_turn()
    if (@board.find_index(0))
      make_move(server_random_move, @server)
    end
  end

  def player_turn(cell)
    if valid_move(cell, @user)
      @message = "Muy bien. Sigue asi."
      make_move(cell, @user)
      server_turn()
    else
      @message = "Movimiento Invalido. Intentalo de nuevo."
    end
  end

  def valid_move(cell, player)
    if @board[cell] == 0
      @board[cell] = player
      return true
    else
      return false
    end
  end

  def make_move(cell, player)
    if @game_ended == false
      @board[cell] = player
      find_winner()
    end
  end

  def server_random_move
    cell = rand(9)
    until @board[cell] == 0
      cell = rand(9)
    end
    return cell
  end

  def find_winner
    patterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [6, 4, 2],
    ]
    patterns.each_with_index {
      |array, index|
      symbol = 0
      counter = 1
      for cell in array
        if @board[cell] == 0
          break
        end
        if symbol == 0
          symbol = @board[cell]
        else
          if symbol != @board[cell]
            break
          end
          counter = counter + 1
        end
        if counter == 3
          @game_ended = true
          @winner_pattern = array
          @winner = symbol
          if symbol == @user
            @message = "Haz demostrado tu destreza y has salido vencedor del encuentro. Felicidades."
          else
            @message = "Te sientes como Kasparov al perder contra una maquina, sin embargo estas listo para la revancha. Mucha suerte."
          end
        end
      end
    }

    if @game_ended == false
      unless @board.find_index(0)
        @game_ended = true
        @winner_pattern = []
        @message = "El encuentro ha resultado en empate. Al siguiente juego."
      end
    end

  end
end
