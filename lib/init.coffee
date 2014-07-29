VirtualenvView = require './virtualenv-view'

module.exports =
  activate: (state) ->
    console.log("virtualenv activated")
    atom.packages.once 'activated', =>
      @statusBar = atom.workspaceView.statusBar
      @virtualenv = new VirtualenvView(@statusBar)
      @statusBar.prependLeft(@virtualenv)
