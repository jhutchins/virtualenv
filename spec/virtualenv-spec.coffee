{WorkspaceView} = require 'atom'
Virtualenv = require '../lib/virtualenv'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Virtualenv", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('virtualenv')

  describe "when the virtualenv:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.virtualenv')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'virtualenv:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.virtualenv')).toExist()
        atom.workspaceView.trigger 'virtualenv:toggle'
        expect(atom.workspaceView.find('.virtualenv')).not.toExist()
