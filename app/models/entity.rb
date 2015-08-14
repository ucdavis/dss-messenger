class Entity
  attr_accessor :id, :name, :member_count

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

    json.each do |entity|
      e = Entity.new

      e.id = entity["id"]
      e.name = entity["name"]
      e.member_count = entity["member_count"]
      
      entities << e
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

    e = Entity.new

    e.id = json["id"]
    e.name = json["name"]
    e.member_count = json["member_count"]

    return e
  end

  def as_json(options = {})
    {
      :id => self.id,
      :name => self.name,
      :member_count => self.member_count
    }
  end
end
