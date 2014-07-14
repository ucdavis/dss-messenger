class Person < ActiveResource::Base
  self.site = $DSS_RM_SETTINGS['HOST']
  self.user = $DSS_RM_SETTINGS['USER']
  self.password = $DSS_RM_SETTINGS['PASSWORD']
  headers['Accept'] = "application/vnd.roles-management.v1"
  
  def role_symbols
    tokens = []

    role_assignments.each do |r|
      tokens << r.token.to_sym if r.application_name == "DSS Messenger"
      # uncomment this line to override dss-rm roles
      # tokens = [:access] 
    end
    
    return tokens
  end
end
