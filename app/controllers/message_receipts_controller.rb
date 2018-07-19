class MessageReceiptsController < ApplicationController
  filter_resource_access

  def show
    message_receipt = MessageReceipt.find_by(id: params[:id])
    callback_response = message_receipt.message_log.publisher.classify.callback(params[:id], self)
    self.response_body = '' unless performed?
  end
end
