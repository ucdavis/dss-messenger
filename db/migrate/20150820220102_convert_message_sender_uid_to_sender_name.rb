class ConvertMessageSenderUidToSenderName < ActiveRecord::Migration
  def up
    rename_column :messages, :sender_uid, :sender

    Message.all.each do |m|
      if m.sender
        e = Entity.find(m.sender)
        m.sender = e.name

        begin
          m.save!
        rescue ActiveRecord::RecordInvalid => e
          puts "Could not save message ##{m.id}: #{m}. Reason: #{e}"
        end
      end
    end
  end

  def down
    raise "This migration is not reverisble as the senders' UIDs are replaced with the senders' name."
  end
end
