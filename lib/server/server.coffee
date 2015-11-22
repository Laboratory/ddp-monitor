DDPMonitor = @DDPMonitor ? {}

DDPMonitor.Server = new class
  constructor: ->
    console.log 'Create ddp live monitor'
    @_collection = new Meteor.Collection 'DDPMessages'
    @registerCallback()

  registerCallback: ->
    self = @
    #create callback with Meteor env
    callback = Meteor.bindEnvironment (msg, params = {}) ->
      self._collection.insert
        created_at: new Date()
        ddp: msg
        socketInfo: params

    #register callback for sockets monitoring
    Meteor.default_server.stream_server.register (socket) ->
      socket.on 'data', (msg) ->
        callback msg,
          connectionId: @id
          sessionId: @_meteorSession.id
          address: @address
