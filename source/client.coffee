### interface
type Fn = () => unknown
type Level = 'high' | 'low' | 'normal'
type Position = [number, number]
###

# function
class Client extends KeyBinding

  height: 0
  isActive: false
  isFullScreen: false
  isSuspend: false
  left: 0
  position: [1, 1]
  top: 0
  width: 0

  constructor: ->
    super()

<<<<<<< HEAD
=======
    $.setInterval @tick, 100

    @on 'pause', =>
      `Menu, Tray, Icon, off.ico`
      @setPriority 'low'
      @suspend true

    @on 'resume', =>
      `Menu, Tray, Icon, on.ico`
      @setPriority 'normal'
      @suspend false
      @delay 1e3, @setSize

>>>>>>> parent of e64cb9c (updated to v0.0.29)
    `Menu, Tray, Icon, on.ico,, 1`

<<<<<<< HEAD
    unless $.isExisted Config.get 'basic/process'
      if Config.get 'basic/path' then $.open Config.get 'basic/path'
=======
    @setSize()
    @delay 1e3, @report
>>>>>>> parent of e64cb9c (updated to v0.0.29)

    $.wait (Config.get 'basic/process'), @init

  # blur(): void
  blur: ->
    name = 'ahk_class Shell_TrayWnd'
    `WinActivate, % name`

<<<<<<< HEAD
  # checkIsActive(): boolean
  checkIsActive: -> return $.isActive Config.get 'basic/process'
=======
    $.on 'alt + enter', =>
      $.press 'alt + enter'
      @delay 1e3, @setSize
>>>>>>> parent of e64cb9c (updated to v0.0.29)

  # checkMousePosition(): boolean
  checkMousePosition: ->

<<<<<<< HEAD
    [x, y] = $.getPosition()
=======
  # delay(id?: string, time?: number, callback?: Fn): void
  delay: (args...) -> # id, time, callback

    if @isSuspend then return

    len = $.length args
    if len == 1 then [id, time, callback] = [args[0], 0, 0]
    else if len == 2 then [id, time, callback] = ['', args[0], args[1]]
    else [id, time, callback] = args

    hasId = id and id != '~'

    if hasId and timer[id] then $.clearTimeout timer[id]
    unless time then return

    delay = time
    if id[0] == '~' then delay = delay * (1 + $.random() * 0.1) # 100% ~ 110%

    result = $.setTimeout callback, delay
    if hasId then timer[id] = result

  # point(input: Position): Position
  point: (input) -> return [
      @vw input[0]
      @vh input[1]
    ]
>>>>>>> parent of e64cb9c (updated to v0.0.29)

    if x < 0
      # $.move [0, y]
      return false

<<<<<<< HEAD
    if x >= @width
      # $.move [@width - 1, y]
      return false
=======
  # reset(): void
  reset: ->
    @setPriority 'normal'
    @resetTimer()

  # resetTimer(): void
  resetTimer: -> for _timer of timer
    $.clearTimeout _timer
>>>>>>> parent of e64cb9c (updated to v0.0.29)

    if y < 0
      # $.move [x, 0]
      return false

    if y >= @height
      # $.move [x, @height - 1]
      return false

    return true

  # focus(): void
  focus: -> $.activate Config.get 'basic/process'

  # getSize(): void
  getSize: ->

    name = "ahk_exe #{Config.get 'basic/process'}"
    `WinGetPos, __left__, __top__, __width__, __height__, % name`

    @left = __left__
    @top = __top__
    @width = __width__
    @height = __height__

    for key in ['left', 'top', 'width', 'height']
      unless @[key]
        @[key] = 0

    if @left == 0 and @top == 0 and @width == A_ScreenWidth and @height == A_ScreenHeight
      @isFullScreen = true
    else @isFullScreen = false

  # getTaskBarSize(): void
  getTaskBarSize: ->
    name = 'ahk_class Shell_TrayWnd'
    `WinGetPos, __left__, __top__, __width__, __height__, % name`
    return [__left__, __top__, __width__, __height__]

  # init(): void
  init: ->

    @watch()

    @on 'leave', =>
      console.log 'client: leave'
      `Menu, Tray, Icon, off.ico`
      @suspend true
      @setPriority 'low'
      @emit 'idle'

    @on 'enter', =>
      console.log 'client: enter'
      `Menu, Tray, Icon, on.ico`
      @suspend false
      @setPriority 'normal'
      @getSize()
      @setStyle()
      Timer.add 1e3, @getSize
      @emit 'activate'

    @on 'activate', =>
      @isActive = true
      console.log 'client: activate'
      unless @checkMousePosition() then $.move [@width * 0.5, @height * 0.5]

    @on 'idle', =>
      @isActive = false
      console.log 'client: idle'

    $.on 'alt + f4', => Sound.beep 2, =>
      @reset()
      if Config.get 'basic/path'
        $.minimize Config.get 'basic/process'
        $.close Config.get 'basic/process'
        Sound.unmute()
      $.exit()

    $.on 'ctrl + f5', -> Sound.beep 3, =>
      @reset()
      $.reload()

    $.on 'alt + enter', =>
      $.press 'alt + enter'
      @getSize()
      @setStyle()
      Timer.add 1e3, @report

    for direction in ['left', 'right', 'up', 'down']
      $.on "win + #{direction}", =>

        if @isFullScreen then return
        [x, y] = @position

        switch direction
          when 'left' then x -= 1
          when 'right' then x += 1
          when 'up' then y -= 1
          when 'down' then y += 1

        if x < 0 then x = 0
        if x > 2 then x = 2
        if y < 0 then y = 0
        if y > 2 then y = 2

        @position = [x, y]
        @setPosition()

  # reset(): void
  reset: ->
    @setPriority 'normal'
    Timer.reset()

  # setPosition(): void
  setPosition: ->

    [x, y] = @position
    width = ($.round @width / 80) * 80
    height = $.round width / 16 * 9

    switch x
      when 0 then left = 0
      when 1 then left = (A_ScreenWidth - width) * 0.5
      when 2 then left = A_ScreenWidth - width

    switch y
      when 0 then top = 0
      when 1 then top = (A_ScreenHeight - height) * 0.5
      when 2
        [l, t, w, h] = @getTaskBarSize()
        top = A_ScreenHeight - height - h

    name = "ahk_exe #{Config.get 'basic/process'}"
    `WinMove, % name,, % left, % top, % width, % height`
    @getSize()

  # setStyle(): void
  setStyle: ->
    $.setStyle (Config.get 'basic/process'), -0x00040000 # border
    $.setStyle (Config. get 'basic/process'), -0x00C00000 # caption
    if @isFullScreen then return
    @setPosition [1, 1]

  # suspend: (isSuspend: boolean): void
  suspend: (isSuspend) ->

    if isSuspend
      if @isSuspend then return
      @isSuspend = true
      $.suspend true
      @resetTimer()
      return

    unless isSuspend
      unless @isSuspend then return
      @isSuspend = false
      $.suspend false
      return

  # setPriority(level: Level): void
  setPriority: (level) ->
    p = Config.get 'basic/process'
    `Process, Priority, % p, % level`

  # update(): void
  update: ->

    unless @checkIsActive()
      unless @isSuspend then @emit 'leave'
      return

    if @isSuspend then @emit 'enter'
    if @isActive and !@checkMousePosition() then @blur()

  # watch(): void
  watch: ->
    interval = 100
    Timer.loop interval, @update

# execute
Client = new Client()