class Entity < ActiveResource::Base
  self.site = $DSS_RM_SETTINGS['HOST']
  self.user = $DSS_RM_SETTINGS['USER']
  self.password = $DSS_RM_SETTINGS['PASSWORD']
  headers['Accept'] = "application/vnd.roles-management.v1"

  def as_json(options = {})
    {
      :id => self.id,
      :name => self.name
    }
    
  end
end
