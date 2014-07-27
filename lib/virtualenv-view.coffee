{View} = require 'atom'

module.exports =
class VirtualenvView

  constructor: (@workspace) ->
    console.debug("Creating new view with [#{@workspace}]")

  initialize: ->
    console.debug("Testing things")

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  render: ->
    atom.packages.once 'activated', =>
      html = "<span class='inline-block virtualenv'>#{@workspace}</span>"
      atom.workspaceView.statusBar?.prependLeft(html)
