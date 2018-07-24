require 'rake'

namespace :receipts do
  desc 'Move YML MessageReceipts to DynamoDB'
  task :move_to_dynamodb, [:filename] => :environment do |t, args|
    if args[:filename].blank?
      STDERR.puts "Must provide a YAML file as argument"
      exit(-1)
    end

    require 'yaml'

    receipts_yaml = YAML.load_file(args[:filename])
    receipts = receipts_yaml['message_receipts']['records']

    count = 0
    total = receipts.length

    STDOUT.puts "Found #{total} receipts"

    receipts.each do |receipt|
      count += 1

      next if count < 247500

      STDOUT.puts "Progress: #{count} of #{total} (#{((count.to_f / total.to_f) * 100.0).round(1)}%)" if count % 500 == 0

      # Ensure MessageReceipt was not already moved
      existing_receipt = MessageReceipt.find_by_id(receipt[0])
      next if existing_receipt

      encoded_receipt = {
        MessageReceiptId: receipt[0],
        MessageLogId: receipt[1],
        RecipientName: receipt[2],
        RecipientEmail: receipt[3],
        CreatedAt: receipt[4],
        UpdatedAt: receipt[5]
      }

      encoded_receipt[:Viewed] = receipt[6] if receipt[6]
      encoded_receipt[:LoginId] = receipt[7] if receipt[7]
      encoded_receipt[:PerformedAt] = receipt[8] if receipt[8]

      begin
        DynamoDbClient.put_item(
          table_name: DynamoDbTable,
          item: encoded_receipt
        )
      rescue Aws::DynamoDB::Errors::ServiceError => error
        STDERR.puts 'Unable to write to DynamoDB message receipt:'
        STDERR.puts error.message.to_s
      end
    end
  end
end

# resp = DynamoDbClient.describe_table(
#   {
#     table_name: 'DssMessengerMessageReceipts'
#   }
# )

# resp = DynamoDbClient.update_table(
#   {
#     table_name: 'DssMessengerMessageReceipts',
#     global_secondary_index_updates:
#       [
#         { update:
#           { index_name: 'MessageReceiptId-index',
#             provisioned_throughput:
#             { write_capacity_units: 150, read_capacity_units: 150 }
#           }
#         }
#       ]
#   }
# )
