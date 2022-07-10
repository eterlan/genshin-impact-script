<<<<<<< HEAD:source/color-manager.coffee
class ColorManager
=======
class ColorPickerX

  tsLast: 0
>>>>>>> parent of e64cb9c (updated to v0.0.29):source/color-picker.coffee

  constructor: ->

    if Config.get 'debug'
      $.on 'alt + f9', =>
        Sound.beep()
        @pick()

<<<<<<< HEAD:source/color-manager.coffee
  # find(color: number, start: Point, end: Point): Point
  find: Gdip.findColor

  # format(n: string): string
  format: (n) -> return $.replace "0x#{(Format '{:p}', n)}", '0x00', '0x'

  # get(p: Point): number
  get: Gdip.getColor

  # pick(): void
=======
>>>>>>> parent of e64cb9c (updated to v0.0.29):source/color-picker.coffee
  pick: ->

    color = @format @get()
    [x, y] = $.getPosition()

    x1 = $.round (x * 100) / Client.width
    y1 = $.round (y * 100) / Client.height

    console.log "color-picker: #{x1}, #{y1} / #{color}"
    ClipBoard = color

# export
<<<<<<< HEAD:source/color-manager.coffee
ColorManager = new ColorManager()
=======
ColorPicker = new ColorPickerX()
>>>>>>> parent of e64cb9c (updated to v0.0.29):source/color-picker.coffee
