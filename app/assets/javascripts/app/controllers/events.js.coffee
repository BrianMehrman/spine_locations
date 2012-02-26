$ = jQuery.sub()
Event = App.Event

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Event.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
  constructor: ->
    super
    @active @render

  render: ->
    @html @view('events/new')

  back: ->
    @navigate '/events'

  submit: (e) ->
    e.preventDefault()
    event = Event.fromForm(e.target).save()
    @naviate '/events', event.id if event

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Event.find(id)
    @render()

  render: ->
    @html @view('events/edit')(@item)

  back: ->
    @navigate '/events'
   
  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/events'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=back]': 'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Event.find(id)
    @render()

  render: ->
    @html @view('events/edit')(@item)

  back: ->
    @navigate '/events'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/events'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    Event.bind 'refresh change', @render
    Event.fetch()

  render: =>
    events = Event.all();
    @html @view('event/index')(events: events)

  edit: (e) ->
    item = $(e.target).item()
    @navigate '/events', item.id, 'edit'

  destroy:  (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')

  show: (e) ->
    item = $(e.target).item()
    @navigate '/events', item.id

  new: ->
    @navigate '/events/new'
    
class App.Events extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New

  routes:
    '/events/new':        'new'
    '/events/:id/edit':   'event'
    '/events/:id':        'show'
    '/events':            'index'

  default: 'index'
  className: 'stack events'
