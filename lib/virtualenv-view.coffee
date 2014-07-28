{View} = require 'atom'

module.exports =
class VirtualenvView extends View

  @content: ->
    @div class: 'inline-block', =>
      @span class: 'virtualenv', outlet: 'path'

  initialize: (@statusBar) ->
    @subscribe @statusBar, 'active-buffer-changed', @update

  afterAttach: ->
    @update()

  update: =>
    path = process.env.VIRTUAL_ENV
    home = process.env.WORKON_HOME

    if path? and home?
      @path.text(path.replace(home + '/', ''))
    else
      @path.text('')

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()
