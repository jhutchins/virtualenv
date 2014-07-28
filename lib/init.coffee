VirtualenvView = require './virtualenv-view'
spawn = (require 'child_process').spawn

module.exports =
  activate: (state) ->
    console.debug("virtualenv activated")
    atom.packages.once 'activated', =>
      @statusBar = atom.workspaceView.statusBar
      @virtualenv = new VirtualenvView(@statusBar)
      @statusBar.prependLeft(@virtualenv)
