xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "DSS Messenger"
    xml.description "Most recent DSS notifications (RSS)"
    xml.link messages_open_url

    # In case no open messages
    if @open_messages.length == 0
      xml.item do
        xml.title "No active notices."
        xml.description nil
        xml.pubDate Date.today.to_s(:rfc822)
        xml.link nil
        xml.guid nil
      end
    end
      
    for m in @open_messages
      xml.item do
        xml.title m.subject
        xml.description m.impact_statement
        unless m.window_start.nil?
          xml.pubDate m.window_start.to_s(:rfc822)
        else
          xml.pubDate m.created_at.to_s(:rfc822)
        end
        xml.link message_url(m)
        xml.guid message_url(m)
      end
    end
  end
end
