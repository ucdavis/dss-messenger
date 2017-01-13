require 'RestClient'

class Group
  attr_accessor :id, :name, :members

  def self.find(id)
    response = RestClient::Request.new(
      :method => :get,
      :url => $DSS_RM_SETTINGS['HOST'] + "/groups/#{id}",
      :user => $DSS_RM_SETTINGS['USER'],
      :password => $DSS_RM_SETTINGS['PASSWORD'],
      :headers => {
        :accept => "application/vnd.roles-management.v1",
        :content_type => :json
      }
    ).execute

    json = JSON.parse(response)

    g = Group.new

    g.id = json["id"]
    g.name = json["name"]

    members = []

    json["members"].each do |m|
      if m["type"] == "Person"
        members << { id: m["id"], name: m["name"], email: m["email"] }
      else
        Rails.logger.warn "Ignoring a member from group ##{id} because it is also a group (##{m["id"]})"
      end
    end

    g.members = members

    return g
  end
end
