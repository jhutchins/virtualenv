VirtualenvView = require './virtualenv-view'
spawn = (require 'child_process').spawn

module.exports =
  virtualenvView: null

  activate: (state) ->

    console.debug("virtualenv activated")
    console.debug(state)

    path = process.env.VIRTUAL_ENV
    home = process.env.WORKON_HOME

    if path? and home?
      path = path.replace(home + '/', '')
      @virtualenvView = new VirtualenvView(path)
      @virtualenvView.render()
