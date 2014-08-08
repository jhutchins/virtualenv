VirtualenvView = require './virtualenv-view'
VirtualenvListView = require './virtualenv-list-view'
VirtualenvManger = require './virtualenv-manager'

module.exports =
  manager: new VirtualenvManger()

  activate: (state) ->
    @manager.on 'options', (options) =>
      items = ({label: item.name, command: 'virtualenv:change:' + item.name} for item in options)
      atom.menu.add [
        {
          label: 'Packages'
          submenu: [
            {
              label: 'Virtualenv'
              submenu: items
            }
          ]
        }
      ]

    atom.packages.once 'activated', =>
      atom.workspaceView.command 'virtualenv:show', =>
        @manager.emit('selector:show')
      statusBar = atom.workspaceView.statusBar
      if statusBar?
        @virtualenv = new VirtualenvView(statusBar, @manager)
        statusBar.prependLeft(@virtualenv)

      @manager.on 'selector:show', =>
        view = new VirtualenvListView(@manager)
        view.attach()

      console.log("virtualenv activated")
