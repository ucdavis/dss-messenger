class Person < ActiveResource::Base
  self.site = $DSS_RM_SETTINGS['HOST']
  self.user = $DSS_RM_SETTINGS['USER']
  self.password = $DSS_RM_SETTINGS['PASSWORD']
  
  def role_symbols
    tokens = []

    Rails.logger.debug "onetwothreefour"    
    roles.each do |r|
      Rails.logger.debug r.inspect
      tokens << r.token.to_sym if r.application_name == "DSS Messenger"
      # tokens = [:guest]
    end
    
    Rails.logger.debug tokens.inspect
    
    return tokens
  end
end
