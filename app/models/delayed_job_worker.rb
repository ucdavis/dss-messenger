# Contains a method that checks the status of Delayed::Job worker to make sure
# there's one running. Some logic/methods from http://stackoverflow.com/questions/2580871

class DelayedJobWorker
  # Filesystem path for the delayed_job PID file. Default is
  # tmp/pids/delayed_job.pid under Rails.root
  DELAYED_JOB_PID_PATH = "#{Rails.root}/tmp/pids/delayed_job.pid"
  
  # Checks the status of Delayed::Job and returns a status code.  
  # Status codes:
  # +0b00+:: A Delayed::Job worker is running
  # +0b01+:: There's no process detected
  # +0b10+:: There are no jobs locked
  # +0b11+:: Both no process and no locked jobs.
  def self.status
    process_is_dead + jobs_not_locked
  end

  # Checks to see if there are jobs that need working on and none are locked.  
  # Returns:  
  # +0b00+:: if jobs are being worked on or no jobs are waiting.  
  # +0b10+:: if jobs are not being worked on.
  def self.jobs_not_locked
    return 0b10 if Delayed::Job.where('locked_by is not null').count == 0 &&
                   Delayed::Job.all.count > 0
    return 0b00
  end

  # Checks the status of Delayed::Job process and returns a status code.  
  # Status codes:
  # +0b00+:: A Delayed::Job process is running
  # +0b01+:: No process detected
  def self.process_is_dead
    # Process.kill returns 1 both if process is running or pid is nil; fails
    # otherwise. This block also fails if DELAYED_JOB_PID_PATH doesn't exist.
    begin
      pid = File.read(DELAYED_JOB_PID_PATH).strip
      Process.kill(0, pid.to_i)
      0b00
    # No permissions to kill process (but it's running)
    rescue Errno::EPERM
      0b00
    rescue
      0b01
    end
  end
end
