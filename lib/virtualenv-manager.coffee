EventEmitter = (require 'events').EventEmitter

module.exports =
  class VirtualenvManager extends EventEmitter

    constructor: () ->
      path = process.env.VIRTUAL_ENV
      home = process.env.WORKON_HOME

      if path? and home?
        path = path.replace(home + '/', '')

      @env = path
