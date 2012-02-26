$ = jQuery.sub()
Location = App.Location

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Location.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'

  constructor: ->
    super
    @active @render

  render: ->
    @html @view('locations/new')

  back: ->
    @navigate '/locations'

  submit: (e) ->
    e.preventDefault()
    location = Location.fromForm(e.target).save()
    @navigate '/locations', location.id if location

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Location.find(id)
    @render()

  render: ->
    @html @view('locations/edit')(@item)

  back: ->
    @navigate '/locations'
  
  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/locations'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=back]': 'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Location.find(id)
    @render()

  render: ->
    @html @view('locations/show')(@item)

  back: ->
    @navigate '/locations'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/locations'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    Location.bind 'refresh change', @render
    Location.fetch()

  render: =>
    locations = Location.all();
    @html @view('locations/index')(locations: locations)

  edit: (e) ->
    item = $(e.target).item()
    @navigate '/locations', item.id, 'edit'

  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')

  show: (e) ->
    item = $(e.target).item()
    @navigate '/locations', item.id

  new: ->
    @navigate '/locations/new'

class App.Locations extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New

  routes:
    '/locations/new':          'new'
    '/locations/:id/edit':     'edit'
    '/locations/:id':          'show'
    '/locations':              'index'

  default: 'index'
  className: 'stack locations'
