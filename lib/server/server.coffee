DDPMonitor = @DDPMonitor ? {}

DDPMonitor.Server = new class
  constructor: ->
    console.log 'Create ddp live monitor'
    @_collection = new Meteor.Collection 'DDPMessages'
    #create TTL index
    #FIXME: Need move ttl options to external settings
    @_collection._ensureIndex
      create_at: -1
    ,
      expireAfterSeconds: 60 * 60 * 24 * 7 #one week

    @registerCallback()

  registerCallback: ->
    self = @
    #create callback with Meteor env
    callback = Meteor.bindEnvironment (msg, info = {}) ->
      self._collection.insert
        created_at: new Date()
        ddp: msg
        socketInfo: info

    #register callback for sockets monitoring
    Meteor.default_server.stream_server.register (socket) ->
      socket.on 'data', (msg) ->
        callback msg,
          connectionId: @id
          sessionId: @_meteorSession.id
          address: @address
