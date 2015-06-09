AGGIE_FEED_SETTINGS_FILE = "#{Rails.root.to_s}/config/aggie_feed.yml"

if File.file?(AGGIE_FEED_SETTINGS_FILE)
  $AGGIE_FEED_SETTINGS = YAML.load_file(AGGIE_FEED_SETTINGS_FILE)
else
  puts "You need to set up config/aggie_feed.yml before running this application."
  exit
end
