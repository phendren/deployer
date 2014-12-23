# deployer attributes - configure repository and deploy user
# as well as SSL related
# deployer - phendren


default[:deployer][:user] = 'deployuser'
default[:deployer][:group] = 'deployuser'
default[:deployer][:home] = '/home/deployuser'
default[:deployer][:git_repo] = 'git@github.com:phendren/empty.git'  
default[:deployer][:repo_branch] = 'staging'
default[:deployer][:project_domain] = 'mydomain.com'
default[:deployer][:project_dir] = 'project'
default[:deployer][:ssl_cert] = 'mydomain.com.crt'
default[:deployer][:ssl_ca] = 'mydomain.com.ca'
default[:deployer][:ssl_key] = 'mydomain.com.key'
default[:deployer][:keep_releases] = '4'
