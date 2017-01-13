require 'RestClient'

class Entity
  attr_accessor :id, :name, :member_count, :type, :members, :email, :loginid

  # While self.find mimics ActiveRecord.find, we've chosen to simply make a
  # separate method call instead of implementing ActiveRecord.find(:all, :params ...)
  def self.search(query)
    response = RestClient::Request.new(
      :method => :get,
      :url => $DSS_RM_SETTINGS['HOST'] + "/entities",
      :user => $DSS_RM_SETTINGS['USER'],
      :password => $DSS_RM_SETTINGS['PASSWORD'],
      :headers => {
        :accept => "application/vnd.roles-management.v1",
        :content_type => :json,
        :params => { :q => query }
      }
    ).execute

    json = JSON.parse(response)

    entities = []

    json.each do |entity_json|
      entities << new_entity(entity_json)
    end

    return entities
  end

  def self.find(id)
    response = RestClient::Request.new(
      :method => :get,
      :url => $DSS_RM_SETTINGS['HOST'] + "/entities/#{id}",
      :user => $DSS_RM_SETTINGS['USER'],
      :password => $DSS_RM_SETTINGS['PASSWORD'],
      :headers => {
        :accept => "application/vnd.roles-management.v1",
        :content_type => :json
      }
    ).execute

    json = JSON.parse(response)

    return new_entity(json)
  end

  def as_json(options = {})
    {
      :id => self.id,
      :name => self.name,
      :member_count => self.member_count
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
