class TictactoeController < ApplicationController
  def new
    clear_session
    @tictactoe = Tictactoe.new
    @tictactoe.start
    update_session
    respond_to do |format|
      format.html { render json: @tictactoe }
    end
  end

  def move
    @tictactoe = Tictactoe.new
    @tictactoe.board = session[:game].board
    @tictactoe.player_turn(params[:number].to_i)
    update_session
    respond_to do |format|
      format.html { render json: @tictactoe }
    end
  end

  private
  def update_session
    session[:game] = @tictactoe
  end

  private
  def clear_session
    session[:game] = nil
  end
end
