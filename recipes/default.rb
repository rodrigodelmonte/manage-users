#
# Cookbook Name:: manage-users
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
users = data_bag('managed_users')

users.each do |login|
  managed_user = data_bag_item('managed_users', login)

  user(login) do
    shell     managed_user['shell']
    comment   managed_user['comment']
    home      managed_user['home']
    supports  :manage_home => true
  end

  directory "/home/#{login}/.ssh" do
    owner login
  end

  file "/home/#{login}/.ssh/authorized_keys" do
    owner login
    mode '644'
    content managed_user['ssh_keys']
  end

  #Grant sudo.
  if managed_user['sudo'] == 'enable'
 
    group "sudo" do
      action :modify
      members login
      append true
    end
    
    sudo_user_file = managed_user['id'].sub('.','-')
    template '/etc/sudoers.d/' + sudo_user_file do
      source "sudoers.erb"
      mode 0440
      owner "root"
      group "root"
      variables({:user => login })
    end	
  end

  #Remove users with status disable.
  if managed_user['status'] == 'disable'
  	
  	user(login) do
      action :remove
  	end

  	sudo_user_file = '/etc/sudoers.d/' + managed_user['id'].sub('.','-')
  	if File.file?(sudo_user_file)
      file sudo_user_file do
        action :delete 
      end
    end
  end

end