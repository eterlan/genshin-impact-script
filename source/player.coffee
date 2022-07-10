### interface
type Fn = () => unknown
type Slot = 1 | 2 | 3 | 4 | 5
###

# function

class Player extends KeyBinding

  constructor: ->
    super()

    @aboutSkill()
    @aboutSwitch()

    # attack
<<<<<<< HEAD
    @registerEvent 'attack', 'l-button'
=======
    @bindEvent 'attack', 'l-button', 'prevent'

    # use skill
    @bindEvent 'use-e', 'e'
    @bindEvent 'use-q', 'q', 'prevent'
>>>>>>> parent of e64cb9c (updated to v0.0.29)

    # others
    @registerEvent 'pick', 'f', 'prevent'

  # aboutSkill(): void
  aboutSkill: ->
    @registerEvent 'use-e', 'e'
    @registerEvent 'use-q', 'q'
    @on 'use-e:start', -> Skill.record 'start'
    @on 'use-e:end', -> Skill.record 'end'
    @on 'use-q:start', Skill.useQ

  # aboutSwitch(): void
  aboutSwitch: ->

    for key in [1, 2, 3, 4, 5]
      @registerEvent 'raw-switch', key
      $.on "alt + #{key}", => @switchQ key

    for step in ['start', 'end']
      @on "raw-switch:#{step}", (key) =>
        unless Scene.is 'normal' then return
        unless key <= Party.total then return
        @emit "switch:#{step}", key

    @on 'switch:start', (key) =>

      Party.switchTo key
      @waitForSwitch 'start', key, =>

        onSwitch = @getOnSwitch()
        unless onSwitch then return

        if onSwitch == 'e'
          $.press 'e:down'
          Skill.record 'start'
          return

    @on 'switch:end', (key) => @waitForSwitch 'end', key, => Timer.add 50, =>

      onSwitch = @getOnSwitch()
      unless onSwitch then return

      if onSwitch == 'e'
        $.press 'e:up'
        Skill.record 'end'
        return

      Tactic.start onSwitch, true

  # getOnSwitch(): string
  getOnSwitch: ->

    {name} = Party
    unless name then return ''

    {onSwitch} = Character.get name
    unless onSwitch then return ''

    return onSwitch

  # switchQ(key: Slot): void
  switchQ: (key) ->
<<<<<<< HEAD

    if key == Party.current
      Skill.useQ()
      return

    Skill.switchQ key

  # waitForSwitch(token: string, n: Slot, callback: Fn)
  waitForSwitch: (token, n, callback) ->

    interval = 50
    limit = 1e3
    token = "player/wait-for-switch-#{token}"

    Timer.remove token

    tsCheck = $.now()
    Timer.loop token, interval, ->

      if n == Party.current
        Timer.remove token
        callback()
        return

      unless $.now() - tsCheck >= limit then return
      Timer.remove token
=======
    $.press "alt + #{key}"
    Party.switchTo key
    SkillTimer.listQ[Party.current] = $.now()

  # useE(isHolding: boolean = false): void
  useE: (isHolding = false) ->

    delay = 50
    if isHolding then delay = 1e3

    $.press 'e:down'
    SkillTimer.record 'start'
    Client.delay '~player', delay, ->
      $.press 'e:up'
      SkillTimer.record 'end'

  # useQ(): void
  useQ: ->
    $.press 'q'
    SkillTimer.listQ[Party.current] = $.now()
>>>>>>> parent of e64cb9c (updated to v0.0.29)

# execute
Player = new Player()