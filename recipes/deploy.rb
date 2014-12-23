# deployer::deploy recipe - this will deploy code from Github
# and is intended to be used with AWS OpsWorks
# phendren - gocodeyourself@gmail.com

known_file = "/home/#{node[:deployer][:user]}/.ssh/known_hosts"

bash "pre_deploy" do
   cwd "/var/www"
   user "root"
   group "root"
   code <<-EOH
       if [ ! -f #{known_file} ]; then
	ssh-keyscan -t rsa,dsa github.com > #{known_file}
 	fi
       mkdir -p /var/www/html/#{node[:deployer][:project_dir]}
       chown #{node[:deployer][:user]}.apache html
       chmod 0755 html
       cd html
       chown #{node[:deployer][:user]}.apache #{node[:deployer][:project_dir]}
       chmod 0755 #{node[:deployer][:project_dir]}
     EOH
end


deploy "/var/www/html/#{node[:deployer][:project_dir]}" do
  repo "#{node[:deployer][:git_repo]}"
  revision "#{node[:deployer][:repo_branch]}" 
  user "#{node[:deployer][:user]}"
  migrate false
  keep_releases 4 
  action :deploy
  scm_provider Chef::Provider::Git 
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlinks.clear
end

template 'deployer.conf' do
  path "/etc/httpd/conf.d/deployer.conf"
  source 'deployer.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

bash "post_dep" do
  cwd "/var/www/html/#{node[:deployer][:project_dir]}"
  user "root"
  group "root"
  code <<-EOH
	chown apache.apache current
	chown -R apache.apache releases
       EOH
end

service 'httpd' do
action :restart
end
