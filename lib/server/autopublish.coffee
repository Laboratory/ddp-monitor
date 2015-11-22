Meteor.startup ->
  Meteor.publish 'DDPLiveMonitor', (params = {}) ->
    self = @
    cursor = DDPMonitor.Server._collection.find params.find or {}
    ,
      sort:
        created_at: -1
      limit: params.limit or 10
    cursor.observeChanges
      added: (id, doc) ->
        self.added "DDPLiveMonitor", id, doc
      removed: (id) ->
        self.removed "DDPLiveMonitor", id

    self.ready()
