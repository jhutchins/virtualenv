VirtualenvView = require './virtualenv-view'
VirtualenvListView = require './virtualenv-list-view'
VirtualenvManger = require './virtualenv-manager'

module.exports =
  manager: new VirtualenvManger()

  activate: (state) ->
    console.log("virtualenv activated")

    atom.packages.once 'activated', =>
      statusBar = atom.workspaceView.statusBar
      if statusBar?
        @virtualenv = new VirtualenvView(statusBar, @manager)
        statusBar.prependLeft(@virtualenv)

      @manager.on 'selector:show', =>
        view = new VirtualenvListView(@manager)
        view.attach()
