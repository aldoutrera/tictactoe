# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  tictactoe = () ->
    @gameOn = false
    @config =
      selectors:
        cell: '.cell'
        cellIdPrefix: '#cell-'
        messageContainer: '.messages'
        newGameButton: '#newGameButton'
      messages:
        startFirst: 'Inicia un nuevo juego'
      ajaxCalls:
        newGame:
          url: '/tictactoe/new'
          type: 'GET'
          dataType: 'json'
        playerMove:
          url: '/tictactoe/move/'
          type: 'GET'
          dataType: 'json'
          data:
            number: 0

    @start = () =>
      @addListeners()
      return

    @addListeners = () =>
      @boardListener()
      @newGameListener()
      return

    @newGameListener = () =>
      $(@config.selectors.newGameButton).click () =>
        @gameOn = true
        $(@config.selectors.cell + '.winner-row').removeClass "winner-row"
        request = $.ajax @config.ajaxCalls.newGame
        request.done (serverResponse) =>
          @updateGame serverResponse
          return
        return
      return

    @boardListener = () =>
      $(@config.selectors.cell).click (event) =>
        if @gameOn
          @playerTurn event
        else
          @alertMessage @config.messages.startFirst
        return
      return

    @playerTurn = (clickedCell) =>
      elementData = $(clickedCell.currentTarget).attr('id').split('-')
      elementId   = elementData[1]
      @config.ajaxCalls.playerMove.data.number = elementId
      request = $.ajax @config.ajaxCalls.playerMove
      request.done (serverResponse) =>
        @updateGame serverResponse
        return
      return

    @updateGame = (serverResponse) =>
      @updateBoard serverResponse.board
      @inGameMessage serverResponse.message
      @checkWinner serverResponse
      return

    @updateBoard = (board) =>
      $.each board, (index, value) =>
        switch value
          when 0 then $(@config.selectors.cellIdPrefix + index).html '<p>&nbsp;</p>'
          when 1 then $(@config.selectors.cellIdPrefix + index).html '<p class="cross">X</p>'
          when 2 then $(@config.selectors.cellIdPrefix + index).html '<p class="circle">O</p>'
        return
      return

    @checkWinner = (serverResponse) =>
      if serverResponse.game_ended is true
        @gameOn = false
        console.log serverResponse.winner_pattern
        $.each serverResponse.winner_pattern, (index, value) =>
          $(@config.selectors.cellIdPrefix + value).addClass "winner-row"
          return
      return

    @inGameMessage = (message) =>
      $(@config.selectors.messageContainer).html message
      return

    @alertMessage = (message) =>
      alert message
      return

    return

  game = new tictactoe()
  game.start()

  return
