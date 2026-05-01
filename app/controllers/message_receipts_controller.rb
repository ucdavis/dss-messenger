class MessageReceiptsController < ApplicationController
  skip_before_action :authenticate, only: [:show]
  before_action :set_message_receipt, only: [:show]

  def show
    @message_receipt&.message_log&.publisher&.classify&.callback(params[:id], self)
    self.response_body = '' unless performed?
  end

  private

  def set_message_receipt
    @message_receipt = MessageReceipt.find_by_id(params[:id]) if params[:id]
  end
end
