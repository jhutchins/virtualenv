EventEmitter = (require 'events').EventEmitter
exec = (require 'child_process').exec

compare = (a,b) ->
  if a.name < b.name
    return -1
  if a.name > b.name
    return 1
  return 0

module.exports =
  class VirtualenvManager extends EventEmitter

    constructor: () ->
      @path = process.env.VIRTUAL_ENV
      @home = process.env.WORKON_HOME

      if @path?
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
      cmd = 'find . -maxdepth 3 -name activate'
      @options = []
      exec cmd, {'cwd' : @home}, (error, stdout, stderr) =>
        for opt in (path.trim().split('/')[1] for path in stdout.split('\n'))
          if opt
            @options.push({'name': opt})
        @options.sort(compare)
        @emit('options', @options)

    make: (path) ->
      cmd = 'virtualenv ' + path
      exec cmd, {'cwd' : @home}, (error, stdout, stderr) =>
        if error?
          @emit('error', error, stderr)
        else
          option = {name: path}
          @options.push(option)
          @options.sort(compare)
          @emit('options', @options)
          @change(option)
