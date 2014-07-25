VirtualenvView = require './virtualenv-view'

module.exports =
  virtualenvView: null

  activate: (state) ->
    @virtualenvView = new VirtualenvView(state.virtualenvViewState)

  deactivate: ->
    @virtualenvView.destroy()

  serialize: ->
    virtualenvViewState: @virtualenvView.serialize()
