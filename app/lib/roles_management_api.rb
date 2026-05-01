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
      url: ENV.fetch("ROLES_HOST") + path,
      user: ENV.fetch("ROLES_USER"),
      password: ENV.fetch("ROLES_PASSWORD"),
      headers: headers
    ).execute

    JSON.parse(response)
  end
end
