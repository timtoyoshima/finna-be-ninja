log node[:deploy][:phpapp].inspect
log "DBHOST: " + node[:deploy][:phpapp][:database][:host]

template "#{node[:deploy][:phpapp][:deploy_to]}/current/db-connect.php" do
  source "db-connect.php.erb"
  mode 0660
  group node[:deploy][:phpapp][:group]
  owner node[:deploy][:phpapp][:user]
  variables(
      :host =>     (node[:deploy][:phpapp][:database][:host] rescue nil),
      :user =>     (node[:deploy][:phpapp][:database][:username] rescue nil),
      :password => (node[:deploy][:phpapp][:database][:password] rescue nil),
      :db =>       (node[:deploy][:phpapp][:database][:database] rescue nil)
  )
 
 only_if do
   File.directory?("#{node[:deploy][:phpapp][:deploy_to]}/current")
 end
end	 



