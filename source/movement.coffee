# variable

ts.jump = 0

# function

class Movement extends KeyBinding

  isForwarding: false
  isMoving: false
  count: 0

  constructor: ->
    super()

    # shift
    @registerEvent 'shift', 'l-shift', 'prevent'
    @on 'shift:start', -> $.click 'right:down'
    @on 'shift:end', -> $.click 'right:up'

    # walk
    for key in ['w', 'a', 's', 'd'] then @registerEvent 'walk', key

    @on 'walk:start', =>
      unless @count then @emit 'move:start'
      if @count >= 4 then return
      @count++

    @on 'walk:end', =>
      if @count == 1 then @emit 'move:end'
      if @count <= 0 then return
      @count--

    @on 'move:start', => @isMoving = true
    @on 'move:end', => @isMoving = false

    # forward
    $.on 'alt + w', => Client.delay 'forward', 100, @toggleForward
    @on 'walk:start', @stopForward

    # jump
<<<<<<< HEAD
    @registerEvent 'jump', 'space'
    @on 'jump:start', => @tsJump = $.now()
    @on 'jump:end', =>
=======
    @bindEvent 'jump', 'space', 'prevent'

    @on 'jump:start', ->
      $.press 'space:down'
      ts.jump = $.now()

    @on 'jump:end', ->
>>>>>>> parent of e64cb9c (updated to v0.0.29)

      now = $.now()
      diff = now - ts.jump
      ts.jump = now

      unless (Config.get 'better-jump') and Scene.is 'normal' then return
      unless diff < 350 then return

      Client.delay '~jump', 350 - diff, ->
        Movement.jump()
        ts.jump = $.now()

  # jump(): void
  jump: ->
    $.press 'space'
    ts.jump = $.now()

  # sprite(): void
  sprite: -> $.click 'right'

  # startForward(): void
  startForward: ->

    unless Scene.is 'normal' then return
    if @isForwarding then return

    @isForwarding = true
    Hud.render 0, 'auto forward [ON]'

    $.press 'w:down'

  # stopForward(): void
  stopForward: ->

    # unless Scene.is 'normal' then return
    unless @isForwarding then return

    @isForwarding = false
    Hud.render 0, 'auto forward [OFF]'

    $.press 'w:up'

  # toggleForward(): void
  toggleForward: ->
    if @isForwarding then @stopForward()
    else @startForward()

# execute
Movement = new Movement()