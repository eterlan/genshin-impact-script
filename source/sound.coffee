import '../../gis-static/lib/ShiftAppVolume.ahk'

### interface
type Fn = () => unknown
###

# variable
timer.beep = 0

# function
class Sound

  index: 0

  constructor: ->
    if Config.get 'sound/use-mute-when-idle'
      Client.on 'idle', @mute
      Client.on 'activate', @unmute
    @unmute()

  # beep(n: number = 1, callback?: Fn): void
  beep: (n = 1, callback = '') ->

    unless Config.get 'sound/use-beep'
      if callback then callback()
      return

    $.beep()

    if n == 1
      if callback then callback()
      return
    @index = 1

    $.clearInterval timer.beep
    timer.beep = $.setInterval =>
      $.beep()
      @index++
      if @index >= n
        $.clearInterval timer.beep
        if callback then callback()
    , 200

  # mute(): void
  mute: -> ShiftAppVolumeTopped (Config.get 'basic/process'), 0

  # play(name: string): void
  play: (name) ->
    unless Config.get 'sound' then return
    $.play "audio/#{name}"

  # unmute(): void
  unmute: -> ShiftAppVolumeTopped (Config.get 'basic/process'), 1

# execute
Sound = new Sound()