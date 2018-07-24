region = Rails.application.secrets[:dynamodb_region]
access_key = Rails.application.secrets[:dynamodb_access_key]
secret_key = Rails.application.secrets[:dynamodb_secret_key]

Aws.config.update({
  region: region,
  credentials: Aws::Credentials.new(access_key, secret_key)
})

if region && access_key && secret_key
  ::DynamoDbClient = Aws::DynamoDB::Client.new
  ::DynamoDbTable = Rails.application.secrets[:dynamodb_message_receipt_table]
end
