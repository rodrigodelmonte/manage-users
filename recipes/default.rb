#
# Cookbook Name:: manage-users
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'sudo'

users = data_bag('managed_users')

group 'sysadmin' do
  action :create
  append true
end

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
    	group 'sysadmin' do
        action :modify
        members login
      end
  end

  #Remove users disabled.
  if managed_user['status'] == 'disable'
   	user(login) do
       action :remove
    end
  end
end