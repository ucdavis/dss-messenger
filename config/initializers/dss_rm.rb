DSS_RM_SETTINGS_FILE = "#{Rails.root.to_s}/config/dss_rm.yml.erb"

if File.file?(DSS_RM_SETTINGS_FILE)
  $DSS_RM_SETTINGS = YAML.load (ERB.new File.new(DSS_RM_SETTINGS_FILE).read).result(binding)
else
  puts "You need to set up config/dss_rm.yml before running this application."
  exit
end
