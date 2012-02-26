class App.Location extends Spine.Model
  @configure 'Location', 'address', 'latitude', 'longitude', 'description', 'name'
  @extend Spine.Model.Ajax