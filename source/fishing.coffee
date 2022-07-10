### interface
type Point = [number, number] | [string, string]
type Shape = 0 | 1 | 2 # return, return, pull
###
# function
class Fishing

  isActive: false
  isPulling: false

  constructor: ->
    $.on 'f11', @toggle

  # checkIsFishing(): boolean
  checkIsFishing: -> return !!(@findColor 0xFFFFFF, ['94%', '94%'], ['98%', '97%'])

  # checkShapre(): Shape
  checkShape: ->

    color = 0xFFFFC0
    start = ['35%', '8%']
    end = ['65%', '18%']

    p1 = @findColor color, start, end
    unless p1 then return 0

    p2 = @findColor color, [start[0], p1[1] + 5], end
    unless p2 then return 0

    if p1[0] - p2[0] > (Point.vw 2) then return 1
    return 2

  # checkStart(): boolean
  checkStart: -> return !(@findColor 0xFFE92C, ['82%', '87%'], ['87%', '97%'])

  # findColor(color: string, start: Point, end: Point): Point | false
  findColor: (color, start, end) ->
<<<<<<< HEAD
    p = ColorManager.find color, (Point.new start), Point.new end
    if Point.isValid p then return p
=======
    [x, y] = $.findColor color, start, end
    if x * y > 0 then return [x, y]
>>>>>>> parent of e64cb9c (updated to v0.0.29)
    return false

  # next(): void
  next: ->

    @isPulling = false

    Client.delay '~fishing', 2e3, =>
      $.press 'l-button'
      Client.delay '~fishing', 1e3, @start

  # pull(): void
  pull: ->
    @isPulling = true
    $.press 'l-button:down'
    Client.delay '~', 50, -> $.press 'l-button:up'

  # start(): void
  start: ->
    Client.delay 'fishing/notice', 60e3, -> Sound.beep 3
    $.press 'l-button'

  # toggle(): void
  toggle: ->

    @isActive = !@isActive

    $.clearInterval timer.fishing
    Client.delay '~fishing'
    Client.delay 'fishing/notice'

    if @isActive
<<<<<<< HEAD
      Scene.is 'fishing'
      Timer.loop 'fishing/watch', 100, @watch
      Hud.render 0, 'auto fish [ON]'
=======
      Scene.name = 'fishing'
      timer.fishing = $.setInterval @watch, 100
      msg = 'enter fishing mode'
      if Config.data.region == 'cn' then msg = '开启钓鱼模式'
      Hud.render 5, msg
>>>>>>> parent of e64cb9c (updated to v0.0.29)
    else
      Scene.is 'unknown'
      Hud.render 0, 'auto fish [OFF]'

  # watch(): void
  watch: ->

    unless @checkIsFishing() then return

    shape = @checkShape()

    unless shape

      if @isPulling
        @next()
        return

      unless @checkStart() then return
      @start()
      return

    unless shape == 2 then return

    @pull()

# execute
Fishing = new Fishing()