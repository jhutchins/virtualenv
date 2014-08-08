EventEmitter = (require 'events').EventEmitter
exec = (require 'child_process').exec

module.exports =
  class VirtualenvManager extends EventEmitter

    constructor: () ->
      @path = process.env.VIRTUAL_ENV
      @home = process.env.WORKON_HOME

      if @path? and @home?
        @env = @path.replace(@home + '/', '')
      else
        @env = '<None>'

      @get_options()

      atom.packages.once 'activated', =>
        @on 'options', (options) =>
          for option in options
            @register(option)

    register: (option) ->
      atom.workspaceView.command 'select-virtualenv:' + option.name, =>
        @change(option)

    change: (env) ->
      if @path?
        newPath = @path.replace(@env, env.name)
        process.env.PATH = process.env.PATH.replace(@path, newPath)
      else
        @path = @home + '/' + env.name
        process.env.PATH = @path + '/bin:' + process.env.PATH
      @path = newPath
      @env = env.name
      @emit('virtualenv:changed')

    deactivate: () ->
      process.env.PATH = process.env.PATH.replace(@path + '/bin:', '')
      @path = null
      @env = '<None>'
      @emit('virtualenv:changed')

    get_options: () ->
      exec 'find . -maxdepth 3 -name activate', {'cwd' : @home}, (error, stdout, stderr) =>
        if error?
          @options = []
          @emit('error', error, stderr)
        else
          opts = []
          for opt in (path.trim().split('/')[1] for path in stdout.split('\n'))
            if opt
              opts.push({'name': opt})
          opts.sort()
          @options = opts
          @emit('options', opts)
