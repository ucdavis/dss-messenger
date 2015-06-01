require 'net/http'

class Activity < ActiveResource::Base
  def create
    self.icon = "icon-plane"
    self.actor = {
      id: $AGGIE_FEED_SETTINGS['SOURCE_ID'],
      objectType: "department",
      displayName: "DSS",
      author: {
        id: "darthvader1971",
        displayName: "Sith Lord"
      }
    }
    self.verb = "post"
    self.ucdEdusMeta = { labels: [ "~campus-messages" ] }
    self.object[:ucdSrcId] = "123456789"
    self.object[:objectType] = "notification"

#    logger.info encode
    uri = URI.parse($AGGIE_FEED_SETTINGS['HOST'])
    http = Net::HTTP.new(uri.host, uri.port)
    http.set_debug_output Logger.new(STDERR)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    headers = Hash.new
    headers['Authorization'] = "ApiKey #{$AGGIE_FEED_SETTINGS['KEY']}"
    headers['Content-Type'] = "application/json"

#    response = http.request_post('/api/v1/activity', encode, headers)
#    request = Net::HTTP::Post.new(collection_path, headers)
    request = Net::HTTP::Post.new('/api/v1/activity', headers)
    request.body = encode
    response = http.request(request)

#    logger.info response.body
  end

  def self.collection_path(prefix_options = {}, query_options = nil)
    "#{prefix(prefix_options)}activity"
  end
end
