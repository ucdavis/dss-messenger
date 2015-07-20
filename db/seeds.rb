require 'active_record/fixtures'

unless Classification.exists?
  ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "classifications")
end
unless Modifier.exists?
  ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "modifiers")
end
unless ImpactedService.exists?
  ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "impacted_services")
end
unless Setting.exists?
  ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "settings")
end

# Scan app/publisher directory for Publishers and add them to the database
Dir.entries(Rails.root + "app/publishers")
.map do |x|
  unless x.start_with?(".") || File.directory?(x) || ! x.end_with?(".rb")
    class_file = File.open(Rails.root + "app/publishers/" + x)
    until class_file.eof()
      class_line = class_file.readline()
      break class_line.gsub(/.* (.*) < Publisher/, '\1').strip  if class_line.include? "< Publisher"
      break if class_line.start_with? "class"
    end
  end
end
.delete_if { |x| x.nil? }
.uniq
.map do |publisher|
  # Don't overwrite/re-add previously added publishers
  if Publisher.where(class_name: publisher).first.nil?
    new_publisher = Publisher.new
    new_publisher.class_name = publisher
    new_publisher.name = publisher.underscore.humanize.titleize.gsub(/ Publisher$/, '').strip
    new_publisher.save!
  end
end
