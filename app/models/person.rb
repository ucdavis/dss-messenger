class Person
  attr_accessor :id, :name, :loginid, :email, :role_symbols

  def self.find(id)
    response = RestClient::Request.new(
      :method => :get,
      :url => $DSS_RM_SETTINGS['HOST'] + "/people/#{id}",
      :user => $DSS_RM_SETTINGS['USER'],
      :password => $DSS_RM_SETTINGS['PASSWORD'],
      :headers => {
        :accept => "application/vnd.roles-management.v1",
        :content_type => :json
      }
    ).execute

    json = JSON.parse(response)

    p = Person.new

    p.id = json["id"]
    p.name = json["name"]
    p.loginid = json["loginid"]
    p.email = json["email"]

    tokens = []

    json["role_assignments"].each do |ra|
      tokens << ra["token"].to_sym if ra["application_name"] == "DSS Messenger"
    end

    p.role_symbols = tokens

    return p
  end
end
