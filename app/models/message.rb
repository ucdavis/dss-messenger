class Message < ActiveRecord::Base
  attr_accessible :impact_statement, :other_services, :purpose, :resolution, :sender_uid, :subject, :window_end, :window_start, :workaround
end
