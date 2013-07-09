xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "DSS-Messenger"
    xml.description "Most recent DSS notifications (RSS)"
    xml.link messages_url

    for m in @rssMessages
      xml.item do
        xml.title m.subject
        xml.description m.impact_statement
        xml.pubDate m.created_at.to_s(:rfc822)
        xml.link message_url(m)
        xml.guid message_url(m)
      end
    end
  end
end