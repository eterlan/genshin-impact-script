# function
class Upgrader

<<<<<<< HEAD
  target: '0.0.37'
=======
  target: '0.0.29'
>>>>>>> parent of e64cb9c (updated to v0.0.29)

  # check(): void
  check: ->

<<<<<<< HEAD
    $.get "https://github.com/phonowell/genshin-impact-script/releases/tag/#{@target}", (result) =>

      unless result
        Timer.add 600e3, @check
=======
  constructor: -> Client.delay 1e3, @main

  # confirm(text: string, callback: (data: boolean) => void): void
  confirm: (text, callback) ->
    ```
    MsgBox, 0x4,, % text`
    IfMsgBox Yes
      callback.Call(true)
    else
      callback.Call(false)
    ```

  # get(url, callback: (data: string) => void): void
  get: (url, callback) ->

    try
      whr = ComObjCreate 'WinHttp.WinHttpRequest.5.1'
      whr.Open 'GET', url, true
      whr.Send()
      whr.WaitForResponse()
      callback whr.ResponseText

    catch
      callback ''

  # main(): void
  main: ->

    url = "https://github.com/phonowell/genshin-impact-script/releases/tag/#{@target}"
    @get url, (result) =>

      unless result
        Client.delay 600e3, @main
>>>>>>> parent of e64cb9c (updated to v0.0.29)
        return

      if result == 'Not Found' then return

      msg = "Found new version: v#{@target}\nUpgrade right now?"

      $.confirm msg, (answer) ->
        unless answer then return
        $.open 'https://github.com/phonowell/genshin-impact-script/releases'

# execute
Upgrader = new Upgrader()