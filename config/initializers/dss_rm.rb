DSS_RM_SETTINGS_FILE = "#{Rails.root.to_s}/config/dss_rm.yml"

if File.file?(DSS_RM_SETTINGS_FILE)
  $DSS_RM_SETTINGS = YAML.load_file(DSS_RM_SETTINGS_FILE)
else
  puts "You need to set up config/dss_rm.yml before running this application."
  exit
end