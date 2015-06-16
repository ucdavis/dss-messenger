json.activity do
  json.icon "icon-comment-alt"
  json.actor do
    json.id @id
    json.objectType "department"
    json.displayName "DSS"
    json.author do
      json.id "darthvader1971"
      json.displayName "Sith Lord"
    end
  end
  json.verb "post"
  json.title @title
  json.object do
    json.ucdSrcId "13484535"
    json.objectType "notification"
    json.content @message
    json.ucdEdusModel do
      json.urlDisplayName "View Message"
      json.url @url
    end
  end
  json.to @recipient
  json.published @published
  json.ucdEdusMeta do
    json.labels do
      json.array! ["~campus-messages"]
    end
  end
end
