# Contains a method that checks the status of Delayed::Job worker to make sure
# there's one running.

class DelayedJobWorker
  
  # Returns true if a Delayed::Job worker is running; false otherwise.
  def self.status
    # Delayed::Job is not running if there's no PID and there's jobs to do, but
    # none are locked.
    if Delayed::Job.where('locked_by is not null').count == 0 &&
       Delayed::Job.all.count > 0 &&
       ! File.file?(Rails.root + "tmp/pids/delayed_job.pid")
      false
    else
      true
    end
  end
end
