class MessageReceiptsController < ApplicationController
  filter_resource_access

  #filter_access_to :all, :attribute_check => true

  def show
    message_receipt = MessageReceipt.find_by(id: params[:id])
    callback_response = message_receipt.message_log.publisher.classify.callback(params[:id], self)
    self.response_body = ""  unless performed?
  end
end
