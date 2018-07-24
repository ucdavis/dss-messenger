class MessageReceiptsController < ApplicationController
  def show
    message_receipt = MessageReceipt.find_by_id(params[:id])
    callback_response = message_receipt.message_log.publisher.classify.callback(params[:id], self)
    self.response_body = '' unless performed?
  end
end
