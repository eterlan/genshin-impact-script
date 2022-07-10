### interface
type Color = number
type Group = [string] | [Name, string]
type Name = 'event'
  | 'fishing'
  | 'half-menu'
  | 'menu'
  | 'normal'
  | 'unknown'
using-q
###

# function
class Scene extends EmitterShellX

  isMulti: false
  name: 'unknown'
<<<<<<< HEAD
  subname: 'unknown'
  tsChange: 0
=======
  tsUpdate: 0
>>>>>>> parent of e64cb9c (updated to v0.0.29)

  constructor: ->
    super()

    Client.on 'tick', @update

    @on 'change', =>
<<<<<<< HEAD
      console.log "scene: #{@name}/#{@subname}"
      @tsChange = $.now()

  # check(): [Name, string]
=======
      console.log "scene: #{@name}"
      if @name == 'normal'
        @isMulti = @checkPoint [16, 2], [20, 6], 0xA9E588
        if @isMulti then console.log 'scene: multi-player'

  # check(): void
>>>>>>> parent of e64cb9c (updated to v0.0.29)
  check: ->

    if @checkIsMenu() then return ['menu', 'unknown']
    if @checkIsHalfMenu() then return ['half-menu', 'unknown']
    if @checkIsNormal() then return ['normal', 'unknown']
    if @checkIsEvent() then return ['event', 'unknown']

    return ['unknown', 'unknown']

  # checkIsEvent(): boolean
  checkIsEvent: ->
    unless @checkPoint ['45%', '79%'], ['55%', '82%'], 0xFFC300 then return false
    return true

  # checkIsHalfMenu(): boolean
  checkIsHalfMenu: ->
    start = ['1%', '3%']
    end = ['3%', '6%']
    unless @checkPoint start, end, 0x3B4255 then return false
    unless @checkPoint start, end, 0xECE5D8 then return false
    return true

  # checkIsMenu(): boolean
  checkIsMenu: ->
    start = ['95%', '3%']
    end = ['97%', '5%']
    unless @checkPoint start, end, 0x3B4255 then return false
    unless @checkPoint start, end, 0xECE5D8 then return false
    return true

  # checkIsNormal(): boolean
  checkIsNormal: ->
    if @checkPoint ['2%', '17%'], ['4%', '21%'], 0xFFFFFF then return true
    if @checkPoint ['95%', '2%'], ['97%', '6%'], 0xFFFFFF then return true
    return false

  # checkPoint(start: number, end: number, color: Color): boolean
  checkPoint: (start, end, color) ->
<<<<<<< HEAD
    p = ColorManager.find color, (Point.new start), Point.new end
    return Point.isValid p

  # freeze(name: Name, subname: string, time: number): void
  freeze: (name, subname, time) ->

    unless @is name, subname
      @name = name
      @subname = subname
      @emit 'change'

    @isFrozen = true
    Timer.add 'scene/unfreeze', time, => @isFrozen = false

  # is(name: Name, subname?: string): boolean
  is: (name, subname = '') ->
    @update()
    unless subname then return name == @name
    return name == @name and subname == @subname
=======
    [x, y] = $.findColor color, (Client.point start), Client.point end
    return x * y > 0

  # makeInterval(): number
  makeInterval: ->
    if @name != 'unknown' then return 2e3
    return 200
>>>>>>> parent of e64cb9c (updated to v0.0.29)

  # update(): void
  update: ->

    if @name == 'fishing' then return

<<<<<<< HEAD
    [name, subname] = @check()
    if name == @name and subname == @subname then return
    @name = name
    @subname = subname
    @emit 'change'
=======
    now = $.now()
    unless now - @tsUpdate >= @makeInterval()
      return
    @tsUpdate = now

    name = @check()

    if Config.data.isDebug
      cost = $.now() - now
      if cost >= 20 then console.log "scene/cost: #{cost} ms"

    if name == @name then return

    @name = name
    @emit 'change', @name
>>>>>>> parent of e64cb9c (updated to v0.0.29)

# execute
Scene = new Scene()