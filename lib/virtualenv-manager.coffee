EventEmitter = (require 'events').EventEmitter
exec = (require 'child_process').exec

module.exports =
  class VirtualenvManager extends EventEmitter

    constructor: () ->
      @path = process.env.VIRTUAL_ENV
      @home = process.env.WORKON_HOME
      @env = '<None>'
      @update()

    update: () ->
      if @path? and @home?
        @env = @path.replace(@home + '/', '')

    options: () ->
      exec 'find . -name activate -depth 3', {'cwd' : @home}, (error, stdout, stderr) =>
        if error?
          @emit('error', error, stderr)
        else
          opts = []
          for opt in (path.trim().split('/')[1] for path in stdout.split('\n'))
            if opt
              opts.push({'name': opt})
          opts.sort()
          console.log(opts)
          @emit('options', opts)
