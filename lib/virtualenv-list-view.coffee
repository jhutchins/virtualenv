{SelectListView} = require 'atom'

module.exports =
  class VirtualenvListView extends SelectListView
    initialize: (@manager) ->
      super

      @addClass('virtualenv-selector from-top overlay')
      @list.addClass('mark-active')

      @subscribe this, 'virtualenv-selector:show', =>
        @cancel()
        false

      @manager.once 'options', (options) =>
        @setItems(options)
      @manager.options()

    getFilterKey: ->
      'name'

    viewForItem: (env) ->
      element = document.createElement('li')
      element.classList.add('active') if env.name is @manager.env
      element.textContent = env.name
      element

    confirmed: (env) ->
      @manager.change(env)
      @cancel()

    attach: ->
      @storeFocusedElement()
      atom.workspaceView.append(this)
      @focusFilterEditor()
