class MessageReceiptsController < ApplicationController
  filter_resource_access

  filter_access_to :all, :attribute_check => true

  def show
    message_receipt = MessageReceipt.find_by_id(params[:id])
    callback_response = message_receipt.message_log.publisher.class_name.constantize.callback(params[:id])
    response_options = callback_response.methods

    # Make sure the things we need actually exist (for example, if a module
    # returns nil, none of these should work). These can be part of an object or
    # Struct, and not necessarily part of an ActionDispatch::Response object.
    self.response.headers = callback_response.headers if response_options.include? :headers
    self.response.content_type = callback_response.content_type if response_options.include? :content_type
    if response_options.include? :body
      self.response_body = callback_response.body 
    else
      # Return nothing if no response
      self.response_body = ""
    end
  end
end
