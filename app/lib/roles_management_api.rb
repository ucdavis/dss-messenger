require "net/http"

module RolesManagementApi
  # Executes RM REST request and returns JSON object
  def self.request(path, query = nil)
    uri = URI.parse(ENV.fetch("ROLES_HOST") + path)
    uri.query = URI.encode_www_form(q: query) if query

    request = Net::HTTP::Get.new(uri)
    request["Accept"] = "application/vnd.roles-management.v1"
    request["Content-Type"] = "application/json"
    request.basic_auth(ENV.fetch("ROLES_USER"), ENV.fetch("ROLES_PASSWORD"))

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end

    raise "Roles Management API error: #{response.code} #{response.message}" unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  end
end
