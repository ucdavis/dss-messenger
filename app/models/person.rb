require 'roles_management'

class Person
  attr_accessor :id, :name, :loginid, :email, :role_symbols

  def self.find(id)
    json = RolesManagementApi::request("/people/#{id}")

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

  def superuser?
    self.role_symbols.include?(:superuser)
  end
end
