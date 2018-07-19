module Authentication
  def self.current_user
    Thread.current['_auth_current_user'] || nil
  end

  def self.current_user=(user)
    Thread.current['_auth_current_user'] = user
  end


  def authenticate
    if session[:cas_user]
      Authentication.current_user = Person.find(session[:cas_user])
      logger.info 'User authentication passed due to existing session'
      return
    end

    CASClient::Frameworks::Rails::Filter.filter(self)

    if session[:cas_user]
      logger.debug 'authenticate: cas_user exists in session.'

      # CAS session exists. Has access?
      @user = Person.find(session[:cas_user])

      if @user
        # Valid user found through CAS.
        Authentication.current_user = @user

        logger.info 'Valid CAS user is in our database. Passes authentication.'

        return
      else
        logger.warn 'Valid CAS user is denied. Needs proper access token in RM.'
        flash[:error] = 'You have authenticated but are not allowed access.'

        redirect_to controller: 'site', action: 'access_denied'
      end
    end
  end
end
