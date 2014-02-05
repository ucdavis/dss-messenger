class Entity < ActiveResource::Base
  self.site = $DSS_RM_SETTINGS['HOST']
  self.user = $DSS_RM_SETTINGS['USER']
  self.password = $DSS_RM_SETTINGS['PASSWORD']
  headers['Accept'] = "application/vnd.roles-management.v1"

  def as_json(options = {})
    {
      :id => self.id,
      :name => self.name,
      :members =>
        if self.type == 'Group'
          entity = Entity.find(self.id)
          entity.members.count
        else
          nil
        end
    }
  end
end
