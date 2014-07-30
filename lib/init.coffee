VirtualenvView = require './virtualenv-view'
VirtualenvManger = require './virtualenv-manager'

module.exports =
  activate: (state) ->
    console.log("virtualenv activated")

    manager = new VirtualenvManger()

    atom.packages.once 'activated', =>
      statusBar = atom.workspaceView.statusBar
      if statusBar?
        @virtualenv = new VirtualenvView(statusBar, manager)
        statusBar.prependLeft(@virtualenv)
