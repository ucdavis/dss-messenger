class DelayedJobStatusController < ApplicationController

  def index
    @status = DelayedJobWorker.status

    case @status
    when 0b00
      render :plain => "Yes", :status => :ok
    when 0b01, 0b10
      render :plain => "Maybe", :status => :ok
    else
      render :nothing => true, :status => :"i'm_a_teapot"
    end
  end
end
