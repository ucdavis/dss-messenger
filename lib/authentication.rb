module Authentication
  def self.current_user
    Thread.current['_auth_current_user'] || nil
  end

  def self.current_user=(user)
    Thread.current['_auth_current_user'] = user
  end

  def authorized?
    if cas_login
      @user = Person.find(cas_login)
      return @user.role_symbols.include?(:access)
    end
  end

  def authenticate
    unless cas_login
      head :unauthorized
      return
    end

    if cas_login
      Authentication.current_user = Person.find(cas_login)
      logger.info 'User authentication passed due to existing session'
      return
    end

    if cas_login
      logger.debug 'authenticate: cas_user exists in session.'

      # CAS session exists. Has access?
      @user = Person.find(cas_login)

      if @user && @user.role_symbols.include?(:access)
        # Valid user found through CAS
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

  private

  def cas_login
    session.dig('cas', 'user')
  end
end
