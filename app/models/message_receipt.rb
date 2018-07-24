class MessageReceipt
  require 'securerandom'

  attr_accessor :id, :message_log_id, :recipient_name, :recipient_email,
                :created_at, :updated_at, :viewed, :login_id, :performed_at, :_new_record

  def initialize
    _new_record = true
  end

  def self.find_by_id(id)
    items = []

    query_opts = {
      table_name: DynamoDbTable,
      index_name: "MessageReceiptId-index",
      key_condition_expression: 'MessageReceiptId = :id',
      expression_attribute_values: {
        ':id' => id.to_s
      }
    }

    lek = nil

    loop do
      if lek
        query_output = DynamoDbClient.query query_opts.merge(exclusive_start_key: lek)
      else
        query_output = DynamoDbClient.query(query_opts)
      end

      items << query_output.items

      # when the result doesn't have next page
      break unless (lek = query_output.last_evaluated_key)
    end

    items.flatten!

    return nil if items.length == 0

    item = items[0]

    return instance_from_dynamodb_item(item)
  rescue Aws::DynamoDB::Errors::ServiceError => error
    Rails.logger.error "Unable to fetch message receipt from DynamoDB by message receipt ID #{id}. Error:"
    Rails.logger.error error.message.to_s
    return nil
  end

  def self.find_by_message_log_id(id)
    items = []

    query_opts = {
      table_name: DynamoDbTable,
      key_condition_expression: 'MessageLogId = :id',
      expression_attribute_values: {
        ':id' => id.to_s
      }
    }

    lek = nil

    loop do
      if lek
        query_output = DynamoDbClient.query query_opts.merge(exclusive_start_key: lek)
      else
        query_output = DynamoDbClient.query(query_opts)
      end

      items << query_output.items

      # when the result doesn't have next page
      break unless (lek = query_output.last_evaluated_key)
    end

    items.flatten!

    results = []
    items.each do |item|
      results << instance_from_dynamodb_item(item)
    end

    return results
  rescue Aws::DynamoDB::Errors::ServiceError => error
    Rails.logger.error "Unable to fetch message receipt from DynamoDB by message log ID #{id}. Error:"
    Rails.logger.error error.message.to_s
    return nil
  end

  def save
    old_updated_at = updated_at
    updated_at = Time.now

    if _new_record
      id = SecureRandom.uuid
      created_at = updated_at
    end

    encoded_receipt = {
      MessageReceiptId: id,
      MessageLogId: message_log_id,
      RecipientName: recipient_name,
      RecipientEmail: recipient_email,
      CreatedAt: created_at,
      UpdatedAt: updated_at
    }

    encoded_receipt[:Viewed] = viewed if viewed
    encoded_receipt[:LoginId] = login_id if login_id
    encoded_receipt[:PerformedAt] = performed_at if performed_at

    begin
      DynamoDbClient.put_item(
        table_name: DynamoDbTable,
        item: encoded_receipt
      )

      _new_record = false

      return true
    rescue Aws::DynamoDB::Errors::ServiceError => error
      Rails.logger.error 'Unable to write message receipt to DynamoDB:'
      Rails.logger.error error.message.to_s
      updated_at = old_updated_at
      if _new_record
        created_at = nil
        id = nil
      end

      return false
    end
  end

  def save!
    if save() == false
      raise 'An error occurred while saving to DynamoDB'
    end
  end

  def message_log
    MessageLog.find_by_id(@message_log_id)
  end

  def message
    message_log&.message
  end

  private

  def self.instance_from_dynamodb_item(item)
    receipt = MessageReceipt.new

    receipt.id = item["MessageReceiptId"].to_i
    receipt.message_log_id = item["MessageLogId"].to_i
    receipt.recipient_name = item["RecipientName"]
    receipt.recipient_email = item["RecipientEmail"]
    receipt.created_at = item["CreatedAt"].present? ? Time.zone.parse(item["CreatedAt"]) : nil
    receipt.updated_at = item["UpdatedAt"].present? ? Time.zone.parse(item["UpdatedAt"]) : nil
    receipt.viewed = item["Viewed"]
    receipt.login_id = item["LoginId"]
    receipt.performed_at = item["PerformedAt"].present? ? Time.zone.parse(item["PerformedAt"]) : nil

    receipt._new_record = false

    return receipt
  end
end
