### interface
type Color = number
type Position = [number, number]
###

# function

class Picker

<<<<<<< HEAD
=======
  isAuto: false
  isFound: false
>>>>>>> parent of e64cb9c (updated to v0.0.29)
  isPicking: false
  tsDetect: 0

  constructor: ->
<<<<<<< HEAD
    @init()
    @watch()

  # find(): void
  find: ->
=======

    Client.on 'tick', @next
    Client.on 'tick', @pick
    $.on 'alt + f', @toggle

    Player.on 'pick:start', =>
      $.press 'f'
      unless Config.data.fastPickup then return
      @isPicking = true

    Player.on 'pick:end', => @isPicking = false

  # detect(): void
  detect: ->
>>>>>>> parent of e64cb9c (updated to v0.0.29)

    if @isPicking then return
    unless Scene.is 'normal' then return

<<<<<<< HEAD
    [x, y] = @findColor 0x323232, ['57%', '30%'], ['59%', '70%']
    unless Point.isValid [x, y] then return

    color = @findTitleColor y
    unless color then return

    if color == 0xFFFFFF
      [x1, y1] = @findColor 0xFFFFFF, ['61%', y], ['63%', y + 20]

      # check shape
      if Point.isValid [x1, y1]
        color1 = ColorManager.get [x1 + 1, y1]
        unless color1 then return
        if color1 == 0xFFFFFF then return
=======
    interval = 200
    if @isFound then interval = 50

    now = $.now()
    unless now - @tsDetect >= interval then return
    @tsDetect = now

    # [x, y] = @find ['59%', '30%'], ['61%', '70%'], 0xECE5D8
    # unless x * y > 0
    #   @isFound = false
    #   return

    [x, y] = @find ['57%', '30%'], ['59%', '70%'], 0x323232
    unless x * y > 0
      @isFound = false
      return

    [x, y] = @find ['61%', y], ['63%', y + 1], 0xFFFFFF
    if x * y > 0
      color = $.getColor [x + 1, y]
      if color == 0xFFFFFF
        @isFound = false
        return
>>>>>>> parent of e64cb9c (updated to v0.0.29)

    @isFound = true
    $.press 'f'
    # $.click 'wheel-down'

<<<<<<< HEAD
  # findTitleColor(y: number): string | false
  findTitleColor: (y) ->

    isFound = false

    for color in [0xFFFFFF, 0xCCCCCC, 0xACFF45, 0x4FF4FF, 0xF998FF]
      [x1, y1] = @findColor color, ['63%', y], ['65%', y + 20]
      unless Point.isValid [x1, y1] then continue
      isFound = true
      break

    if isFound then return color
    else return 0

  # findColor(color: Color, start: Position, end: Position): Position
  findColor: (color, start, end) ->
    [x, y] = ColorManager.find color, (Point.new start), Point.new end
    return [x, y]

  # init(): void
  init: ->

    $.on 'alt + f', @toggle

    # why?
    # sometimes pick:end event fired before pick:start event
    # very strange
    fn = =>
      unless @isPicking
        @isPicking = true
        console.log 'picker/is-picking: true'
        $.press 'f'
      else
        @isPicking = false
        console.log 'picker/is-picking: false'

    Player.on 'pick:start', fn
    Player.on 'pick:end', fn

  # listen(): void
  listen: ->
=======
  # find(start: Position, end: Position, color: Color): Position
  find: (start, end, color = 0xFFFFFF) ->
    [x, y] = $.findColor color, (Point.new start), Point.new end
    return [x, y]

  # pick(): void
  pick: ->
>>>>>>> parent of e64cb9c (updated to v0.0.29)
    unless @isPicking then return
    if @skip() then return
    unless Scene.is 'normal' then return
    $.press 'f'
    # $.click 'wheel-down'

  # next(): void
  next: ->

<<<<<<< HEAD
    if (Config.get 'better-pickup/use-quick-skip') and Scene.is 'event'
      @skip()
      return

    if (Config.get 'better-pickup/use-fast-pickup') and Scene.is 'normal'
      @find()
=======
    unless @isAuto then return

    if Config.data.quickEvent and Scene.name == 'event'
      @skip()
      return

    if Config.data.fastPickup and Scene.name == 'normal'
      @detect()
>>>>>>> parent of e64cb9c (updated to v0.0.29)
      return

  # skip(): boolean
  skip: ->

    unless Scene.is 'event' then return false

    Idle.setTimer() # avoid idle
    $.press 'space'

    p = ''
    for color in [0x806200, 0xFFCC32, 0xFFFFFF]
<<<<<<< HEAD
      p1 = @findColor color, ['65%', '40%'], ['70%', '80%']
      if Point.isValid p1
        p = p1
        break
    unless p then return true
=======
      [x, y] = @find ['65%', '40%'], ['70%', '80%'], color
      unless x * y > 0 then continue
      p = [x, y]
      break

    unless p then return false
>>>>>>> parent of e64cb9c (updated to v0.0.29)

    $.move p
    $.click()
    return true

<<<<<<< HEAD
  # watch(): void
  watch: ->

    interval = 100
    token = 'picker/watch'

    fn = =>
      if (Config.get 'better-pickup') and !@isPicking then @next()
      else @listen()

    Client.on 'idle', -> Timer.remove token
    Client.on 'activate', -> Timer.loop token, interval, fn
=======
  # toggle(): void
  toggle: ->

    @isAuto = !@isAuto

    if @isAuto
      msg = 'enter auto-pickup mode'
      if Config.data.region == 'cn' then msg = '开启自动拾取'
      Hud.render 5, msg
    else
      msg = 'leave auto-pickup mode'
      if Config.data.region == 'cn' then msg = '关闭自动拾取'
      Hud.render 5, msg
>>>>>>> parent of e64cb9c (updated to v0.0.29)

# execute
Picker = new Picker()