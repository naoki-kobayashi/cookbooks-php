#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
ROOT_PASSWORD = "4231bann"


class Chef::Resource::Template
  include MycnfParam
end



template "/etc/my.cnf" do
  source "my.cnf.erb"
    mode 0644
    owner "root"
    group "root"



    mysql_params = Hash::new
    get_mysql_params( mysql_params )

    variables({
      :mysql_params => mysql_params
    })


end



execute "setpassword" do
  command "/usr/bin/mysqladmin -u root password " + ROOT_PASSWORD
  action :nothing
end



package "mysql-server" do
  action :install
end



service "mysqld" do
  action [ :enable, :start ]
  notifies :run, resources( :execute  => "setpassword" )
end
