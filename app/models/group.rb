require 'roles_management'

class Group
  attr_accessor :id, :name, :members

  def self.find(id)
    json = RolesManagementApi::request("/groups/#{id}")

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
