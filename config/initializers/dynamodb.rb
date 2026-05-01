region = ENV["DYNAMODB_REGION"].presence
access_key = ENV["DYNAMODB_AWS_ACCESS_KEY"].presence
secret_key = ENV["DYNAMODB_AWS_SECRET_KEY"].presence
table_name = ENV["DYNAMODB_MESSAGE_RECEIPT_TABLE"].presence

if region && access_key && secret_key
    Aws.config.update({
    region: region,
    credentials: Aws::Credentials.new(access_key, secret_key)
  })

  ::DynamoDbClient = Aws::DynamoDB::Client.new
  ::DynamoDbTable = table_name
end
