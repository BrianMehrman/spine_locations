class App.Event extends Spine.Model
  @configure 'Event', 'name', 'location_id', 'description', 'start'
  @extend Spine.Model.Ajax