{$, EditorView, View} = require 'atom'
path = require 'path'
exec = (require 'child_process').exec

module.exports =
class MakeDialog extends View
  @content: ->
    @div class: 'tree-view-dialog overlay from-top', =>
      @label 'Virtualenv name', outlet: 'promptText'
      @subview 'miniEditor', new EditorView(mini: true)
      @div class: 'error-message', outlet: 'errorMessage'

  initialize: (@manager) ->
    @on 'core:confirm', => @onConfirm(@miniEditor.getText())
    @on 'core:cancel', => @cancel()
    @miniEditor.hiddenInput.on 'focusout', => @remove()
    @miniEditor.getEditor().getBuffer().on 'changed', => @showError()

  onConfirm: (path) ->
    @manager.make(path)
    @close()

  attach: ->
    atom.workspaceView.append(this)
    @miniEditor.focus()
    @miniEditor.scrollToCursorPosition()

  close: ->
    @remove()
    atom.workspaceView.focus()

  cancel: ->
    @remove()
    $('.tree-view').focus()

  showError: (message='') ->
    @errorMessage.text(message)
    @flashError() if message
