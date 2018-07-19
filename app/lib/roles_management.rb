module RolesManagementApi
  # Executes RM REST request and returns JSON object
  def self.request(path, query = nil)
    headers = {
      accept: 'application/vnd.roles-management.v1',
      content_type: :json
    }

    headers[:params] = { q: query } if query

    response = RestClient::Request.new(
      method: :get,
      url: Rails.application.secrets[:roles_host] + path,
      user: Rails.application.secrets[:roles_user],
      password: Rails.application.secrets[:roles_password],
      headers: headers
    ).execute

    JSON.parse(response)
  end
end
