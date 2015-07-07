class DelayedJobStatusController < ApplicationController

  def index
    @status = DelayedJobWorker.status

    case @status
    when 0b00
      render :text => "Yes", :status => :ok
    when 0b01, 0b10
      render :text => "Maybe", :status => :ok
    else
      render :nothing => true, :status => :"i'm_a_teapot"
    end
  end
end
