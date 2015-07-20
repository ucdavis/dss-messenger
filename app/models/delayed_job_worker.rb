# Provides 'status' method to check whether a Delayed::Job worker is running.
# Some logic/methods from http://stackoverflow.com/questions/2580871
class DelayedJobWorker
  # Filesystem path for the delayed_job PID file. Default is
  # tmp/pids/delayed_job.pid under Rails.root
  DELAYED_JOB_PID_PATH = "#{Rails.root}/tmp/pids/delayed_job.pid"

  RUNNING               = 0b00
  NO_PROCESS            = 0b01
  NO_LOCKED_JOBS        = 0b10
  NO_PROCESS_NOR_LOCKED = 0b11

  # Checks the status of Delayed::Job and returns a status code.
  def self.status
    process_is_dead + jobs_not_locked
  end

  # Checks to see if there are jobs that need working on and none are locked.
  def self.jobs_not_locked
    return NO_LOCKED_JOBS if Delayed::Job.where('locked_by is not null').count == 0 && Delayed::Job.count > 0
    return RUNNING
  end

  # Checks the status of Delayed::Job process and returns a status code.
  def self.process_is_dead
    # Process.kill returns 1 both if process is running or pid is nil; fails
    # otherwise. This block also fails if DELAYED_JOB_PID_PATH doesn't exist.
    begin
      pid = File.read(DELAYED_JOB_PID_PATH).strip
      Process.kill(0, pid.to_i) # Unix 'kill' of signal 0 just checks if the PID is running
      return RUNNING
    # No permissions to kill process (but it's running)
    rescue Errno::EPERM
      return RUNNING
    rescue
      return NO_PROCESS
    end
  end
end
