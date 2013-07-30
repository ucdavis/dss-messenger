require 'active_record/fixtures'
ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "classifications")
ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "modifiers")
ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "impacted_services")
