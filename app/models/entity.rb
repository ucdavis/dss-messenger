require 'roles_management'

class Entity
  attr_accessor :id, :name, :member_count, :type, :members, :email, :loginid

  # While self.find mimics ActiveRecord.find, we've chosen to simply make a
  # separate method call instead of implementing ActiveRecord.find(:all, :params ...)
  def self.search(query)
    json = RolesManagementApi::request('/entities', query)

    entities = []

    json.each do |entity_json|
      entities << new_entity(entity_json)
    end

    return entities
  end

  def self.find(id)
    json = RolesManagementApi::request("/entities/#{id}")

    return new_entity(json)
  end

  def as_json(options = {})
    {
      id: self.id,
      name: self.name,
      member_count: self.member_count
    }
  end

  private

  def self.new_entity(json)
    e = Entity.new

    e.id = json["id"]
    e.name = json["name"]
    e.email = json["email"]
    e.loginid = json["loginid"]
    e.member_count = json["member_count"]
    e.type = json["type"]
    e.members = []

    if json["members"]
      json["members"].each do |member|
        e.members << { id: member["id"], type: member["type"] }
      end
    end

    return e
  end
end
