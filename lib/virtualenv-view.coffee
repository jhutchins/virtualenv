{View} = require 'atom'

module.exports =
class VirtualenvView extends View
  @content: ->
    @div class: 'virtualenv overlay from-top', =>
      @div "The Virtualenv package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "virtualenv:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "VirtualenvView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
