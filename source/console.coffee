class Console

  intervalCheck: 2e3
  isChanged: false
  lifetime: 10e3
  listContent: []
  tsCheck: 0

  constructor: ->
<<<<<<< HEAD
    unless Config.get 'debug' then return
    @watch()
=======

    unless Config.data.isDebug then return

    Client
      .on 'pause', @hide
      .on 'tick', @check
>>>>>>> parent of e64cb9c (updated to v0.0.29)

  add: (msg) ->

    id = ''
    if $.includes msg, ':' then [id] = $.split msg, ':'

    tsOutdate = $.now() + @lifetime

    unless id
      $.push @listContent, [tsOutdate, msg, id]
      return

    hasId = false
    for item, i in @listContent
      unless id == item[2] then continue
      hasId = true
      @listContent[i] = [tsOutdate, msg, id]
      break

    if hasId then return
    $.push @listContent, [tsOutdate, msg, id]

<<<<<<< HEAD
  # hide(): void
  hide: -> `ToolTip,, 0, 0, 20`

  # log<T>(ipt: T): T
  log: (ipt) ->
=======
  check: ->

    now = $.now()
    unless now - @tsCheck >= @intervalCheck then return
    @tsCheck = now

    len = $.length @listContent
    @listContent = $.filter @listContent, (item) -> return item[0] >= now
    if len != $.length @listContent then @update()

  hide: -> `ToolTip, , 0, 0, 20`

  log: (input) ->
>>>>>>> parent of e64cb9c (updated to v0.0.29)

    if ($.type ipt) == 'array'
      for msg in ipt
        @add msg
    else @add ipt

<<<<<<< HEAD
    @render()
    return ipt
=======
    @update()
    return input
>>>>>>> parent of e64cb9c (updated to v0.0.29)

  update: ->
    list = $.map @listContent, (item) -> return item[1]
    text = $.join list, '\n'
    text = $.trim text, ' \n'
    left = 0 - Client.left
    top = Client.height * 0.5
    `ToolTip, % text, % left, % top, 20`

<<<<<<< HEAD
  # update(): void
  update: ->
    now = $.now()
    len = $.length @listContent
    @listContent = $.filter @listContent, (item) -> return item[0] >= now
    if len != $.length @listContent then @render()

  # watch
  watch: ->

    interval = 500
    token = 'console/watch'

    Client.on 'idle', =>
      Timer.remove token
      @hide()

    Client.on 'activate', =>
      Timer.loop token, interval, @update
      @update()

=======
>>>>>>> parent of e64cb9c (updated to v0.0.29)
# execute
console = new Console()