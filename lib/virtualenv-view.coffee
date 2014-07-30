{View} = require 'atom'

module.exports =
class VirtualenvView extends View

  @content: ->
    @div class: 'inline-block', =>
      @span class: 'virtualenv', outlet: 'path'

  initialize: (@statusBar, @manager) ->
    @subscribe @statusBar, 'active-buffer-changed', =>
      @update

    @subscribe atom.workspace.eachEditor (editor) =>
      @subscribe editor, 'grammar-changed', =>
        @update() if editor is atom.workspace.getActiveEditor()

  afterAttach: ->
    @update()

  update: =>
    grammar = atom.workspace.getActiveEditor()?.getGrammar?()

    if grammar? and grammar.name == 'Python'
      @text(@manager.env).show()
    else
      @hide()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()
