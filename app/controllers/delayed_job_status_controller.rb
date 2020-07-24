class DelayedJobStatusController < ApplicationController
  def index
    status = DelayedJobWorker.status

    case status
    when DelayedJobWorker::RUNNING
      render :plain => "Yes", :status => :ok
    when DelayedJobWorker::NO_PROCESS, DelayedJobWorker::NO_LOCKED_JOBS
      render :plain => "Maybe", :status => :ok
    else
      head :internal_server_error
    end
  end
end
