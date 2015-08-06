class DelayedJobStatusController < ApplicationController
  def index
    status = DelayedJobWorker.status

    case status
    when DelayedJobWorker::RUNNING
      render :text => "Yes", :status => :ok
    when DelayedJobWorker::NO_PROCESS, DelayedJobWorker::NO_LOCKED_JOBS
      render :text => "Maybe", :status => :ok
    else
      render :nothing => true, :status => :error
    end
  end
end
