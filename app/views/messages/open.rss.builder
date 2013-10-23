xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "DSS Messenger"
    xml.description "Most recent DSS notifications (RSS)"
    xml.link messages_open_url

    for m in @open_messages
      mTitle = ''
      unless m.classification.nil?
        mTitle += m.classification.description.slice(0..(m.classification.description.index(':'))) + ' '
      end
      mTitle += m.subject
      unless m.window_start.nil?
        mTitle += ', ' + m.window_start.strftime("%a %-m/%-d %-l:%M%p")
      else
        mTitle += ', ' + m.created_at.strftime("%a %-m/%-d %-l:%M%p")
      end

      xml.item do
        xml.title mTitle
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
