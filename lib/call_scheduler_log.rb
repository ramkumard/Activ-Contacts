class CallSchedulerLog
  def self.debug(message=nil)
    @@log ||= Logger.new("#{Rails.root}/log/call_schedulers.log")
    @@log.debug(message) unless message.nil?
    @@log.debug("")
  end
end