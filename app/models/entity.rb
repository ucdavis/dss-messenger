class Entity < ActiveResource::Base
  self.site = $DSS_RM_SETTINGS['HOST']
  self.user = $DSS_RM_SETTINGS['USER']
  self.password = $DSS_RM_SETTINGS['PASSWORD']

  def as_json(options = {})
    {
      :id => self.id,
      :name => self.name
    }
    
  end
end
