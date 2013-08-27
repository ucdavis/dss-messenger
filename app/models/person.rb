class Person < ActiveResource::Base
  self.site = $DSS_RM_SETTINGS['HOST']
  self.user = $DSS_RM_SETTINGS['USER']
  self.password = $DSS_RM_SETTINGS['PASSWORD']
  headers['Accept'] = "application/vnd.roles-management.v1"
  
  def role_symbols
    tokens = []

    Rails.logger.debug "onetwothreefour"    
    role_assignments.each do |r|
      Rails.logger.debug r.inspect
      tokens << r.token.to_sym if r.application_name == "DSS Messenger"
      # uncomment this line to override dss-rm roles
      # tokens = [:access] 
    end
    
    Rails.logger.debug tokens.inspect
    
    return tokens
  end
end
