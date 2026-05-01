region = ENV["DYNAMODB_REGION"]
access_key = ENV["DYNAMODB_AWS_ACCESS_KEY"]
secret_key = ENV["DYNAMODB_AWS_SECRET_KEY"]

Aws.config.update({
  region: region,
  credentials: Aws::Credentials.new(access_key, secret_key)
})

if region && access_key && secret_key
  ::DynamoDbClient = Aws::DynamoDB::Client.new
  ::DynamoDbTable = ENV["DYNAMODB_MESSAGE_RECEIPT_TABLE"]
end
