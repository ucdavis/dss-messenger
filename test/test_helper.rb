ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'declarative_authorization/maintenance'

class ActiveSupport::TestCase
  include Authorization::TestHelper
  fixtures :all

  def fake_cas_login
    request.session['cas'] = { 'user' => 'okadri' }
  end

  def revoke_all_access
    Authorization.current_user = nil
    request.env.delete('REMOTE_ADDR')
    request.session.delete(:auth_via)
    request.session.delete(:user_id)
    request.session.delete('cas')
  end
end