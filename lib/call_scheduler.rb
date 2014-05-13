class CallSchedulerJob < Struct.new(:file_name,:contact_imports_id,:user_id)
  def perform
		 StatusInfo.delete_all
		 sleep(15)
		 delay=StatusInfo.create(:status=>'100',:status_desc => 'Contacts upload progress',:delayed_id =>@job.id,:delayed_desc =>@job.last_error,:contact_imports_id=>contact_imports_id,:user_id=>user_id )
		 
		 CallSchedulerLog.debug("Call Scheduler job  start --  -- #{Time.current}")
         ContactImport.upload_contacts(file_name,contact_imports_id,user_id,@job)
		
			#~ sleep(15)
		 #~ delay=StatusInfo.last
		 #~ delay.update_attributes(:status => '400' ,:status_desc => 'Sales data upload completed',:delayed_desc =>@job.last_error)
		
		 #~ CallSchedulerLog.debug("royalty data upload sucess --  -- #{Time.current}")
		 #~ response=ActiveRecord::Base.connection.execute ("SELECT royalty_computation_main_proc('#{contract_id}', '#{statement_date}','#{status}');")
		
		#~ delay=StatusInfo.last
		#~ delay.update_attributes(:status => '800', :status_desc => 'Process Completed',:delayed_desc =>@job.last_error)
		#~ #sleep(15)
		#~ # StatusInfo.delete_all
		 #~ CallSchedulerLog.debug("royalty processing sucess --  -- #{Time.current}")
		 CallSchedulerLog.debug("Call Scheduler job  stop --  -- #{Time.current}")
	 end
	 
	 def before(job)
     @job = job
   end
	 
end