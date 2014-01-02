class Tictactoe
  attr_accessor :board, :message

  def initialize
    @board  = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    @user   = 1
    @server = 2
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
    if make_move(cell, @user)
      server_turn()
    end
    find_winner()
  end

  def make_move(cell, player)
    if @board[cell] == 0
      @board[cell] = player
      @message = "Excelente. Sigue asi."
      return true
    else
      @message = "Movimiento Invalido. Intentalo de nuevo."
      return false
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
    patterns = []
  end
end
