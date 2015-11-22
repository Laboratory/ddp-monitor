DDPMonitor = @DDPMonitor ? {}

DDPMonitor.Client = new class
  constructor: ->
    Meteor.subscribe 'DDPLiveMonitor', limit: 10
    @_collection = new Meteor.Collection 'DDPLiveMonitor'
    @_collection.find(
      {}
    ,
      sort:
        created_at: -1
    ).observeChanges
      added: (id, doc) ->
        console.log doc.socketInfo.connectionId, JSON.parse doc.ddp
