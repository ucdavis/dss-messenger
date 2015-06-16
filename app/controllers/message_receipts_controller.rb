class MessageReceiptsController < ApplicationController
  filter_resource_access

  filter_access_to :all, :attribute_check => true

  def show
    message_receipt = MessageReceipt.find_by_id(params[:id])
    message_receipt.message_log.publisher.class_name.constantize.callback(params[:id])
  end
end
