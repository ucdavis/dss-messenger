class DelayedJobStatusController < ApplicationController

  def index
    @status = DelayedJobWorker.status

    if @status
      render :nothing => true, :status => :ok
    else
      render :nothing => true, :status => :"i'm_a_teapot"
    end
  end
end
