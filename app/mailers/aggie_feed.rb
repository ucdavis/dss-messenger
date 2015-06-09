require 'net/http'

# See Rails' actionmailer/lib/action_mailer/base.rb for manually rendering views
class AggieFeed < AbstractController::Base
  include ActionController::Rendering

  include AbstractController::Logger
  include AbstractController::Helpers
  include AbstractController::Translation
  include AbstractController::AssetPaths

  helper ApplicationHelper

  append_view_path Rails.root + 'app/views'

  def create(title, message, url, recipients)
    @id = $AGGIE_FEED_SETTINGS['SOURCE_ID']
    @title = title
    @message = message
    @url = url

    # TODO: Figure out how to use kerberos loginid instead of email. Entity
    @recipients = recipients.map { |m| { id: m.email, g: false, i: false } }
    current_time = Time.now.utc
    @published = current_time.strftime("%Y-%m-%dT%H:%M:%S.000Z")
    
    uri = URI.parse($AGGIE_FEED_SETTINGS['HOST'])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    # TODO: get certificate
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    headers = Hash.new
    headers['Authorization'] = "ApiKey #{$AGGIE_FEED_SETTINGS['KEY']}"
    headers['Content-Type'] = "application/json"

    request = Net::HTTP::Post.new('/api/v1/activity', headers)
    request.body = render(template: 'aggie_feed/create', formats: [:json], handlers: [:jbuilder])
    response = http.request(request)

    response.body
  end

  def content_type
    'application/json'
  end

  def rendered_format
    Mime::JSON
  end

  def self.collection_path(prefix_options = {}, query_options = nil)
    "#{prefix(prefix_options)}activity"
  end
end
