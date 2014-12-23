#
# Cookbook Name::deployer
# Recipe::setup 
#
# phendren
#

cookbook_file "/etc/httpd/ssl/star.staging-soundstrue.com.crt" do
  source "star.staging-soundstrue.com.crt"
  mode '0600'
  owner 'root'
  group 'root'
end

cookbook_file "/etc/httpd/ssl/star.staging-soundstrue.com.ca" do
  source "star.staging-soundstrue.com.ca"
  mode '0600'
  owner 'root'
  group 'root'
end

cookbook_file "/etc/httpd/ssl/star.staging-soundstrue.com.key" do
  source "star.staging-soundstrue.com.key"
  mode '0600'
  owner 'root'
  group 'root'
end

user "#{node[:deployer][:user]}" do
  shell "/bin/bash"
  home "#{node[:deployer][:home]}"
  action :create
end

directory "#{node[:deployer][:home]}/.ssh" do
  owner "#{node[:deployer][:user]}"
  group "#{node[:deployer][:user]}"
  mode '0700'
  action :create
end


cookbook_file "id_rsa" do
  path "#{node[:deployer][:home]}/.ssh/id_rsa"
  source "id_rsa.txt"
  owner "#{node[:deployer][:user]}"
  group "#{node[:deployer][:user]}"
  mode '0600'
  action :create_if_missing
end

directory "/var/www/html/#{node[:deployer][:project_dir]}" do
  owner 'apache'
  group 'apache'
  mode '0755'
  action :create
end

service 'httpd' do
  action :restart
end
