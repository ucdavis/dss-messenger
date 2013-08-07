class DssMessenger.Models.Settings extends Backbone.Model
  paramRoot: 'setting'

  defaults:
    item_name: null
    item_value: null

  toJSON: () ->
    json = _.omit(this.attributes, 'updated_at', 'created_at')


class DssMessenger.Collections.SettingsCollection extends Backbone.Collection
  model: DssMessenger.Models.Settings
  url: '/settings'
