deployer Cookbook
=================
This cookbook can deploy PHP based web apps/utilities built as a custom AWS OpsWorks layer. It was designed to be used in conjunction
with amzapache (installs and configures the Apache web server) and with php-pkg (installs and configures PHP packages).

It has only been tested with AWS OpsWorks - a DevOps Application management framework that utilizes Chef Solo: http://aws.amazon.com/opsworks/

It is designed to run on Amazon Linux and has a dependency of amzapache and pkg-php which will install/configure
Apache and PHP (configurable via attributes).

I elected to write my own cookbooks to create a custom layer in OpsWorks because the official included Amazon OpsWorks cookbooks are effective but
a bit overly complicated. One of the big differences with my cookbook is that the vhosts added by this cookbook (deployer) are created as a .conf file inside of
/etc/httpd/conf.d/<project name>.conf - which is a bit more CentOS/RHE type of a Apache configuration as opposed to the way that Amazon's cookbooks do it, where first no matter which underlying Linux operating system you choose to use - Apache is configured as it would be on Ubuntu (/etc/apache2/sites-enabled, /etc/apache2/sites-available). 
Also note that while this cookbook was designed to be used with OpsWorks specifically - I don't see any reason why it couldn't be adopted to be used with other Chef environments. Feel free to use it, if you would like to contribute to this cookbook, email me or simply fork it.

Attributes
----------
`default[:deployer][:user]` = 'deployuser' - User you want created (should be configured as a user on github)<br>
`default[:deployer][:group]` = 'deployuser'  - Group you want created<br>
`default[:deployer][:home]` = '/home/deployuser' - Home directory for the user<br>
`default[:deployer][:git_repo]` = 'git@github.com:phendren/empty.git' - The repository on github that contains your web application project (ssh URL)<br>
`default[:deployer][:repo_branch]` = 'staging' - The repository branch you want to use<br>
`default[:deployer][:project_domain]` = 'mydomain.com' - The domain you want to use<br>
`default[:deployer][:project_dir]` = 'project' - The directory you want the project to use as a web root<br>
`default[:deployer][:ssl_cert]` = 'mydomain.com.crt' - The name of the SSL certificate file included as a cookbook file<br>
`default[:deployer][:ssl_ca]` = 'mydomain.com.ca' - The name of the SSL ca file included as a cookbook file<br>
`default[:deployer][:ssl_key]` = 'mydomain.com.key'- The name of the SSL key file included as a cookbook file<br>
`default[:deployer][:keep_releases]` = '4' - How many releases would you like to save (automatic rollback planned for the future)<br>

This cookbook also expects that an SSH key (rsa) will have been added as a cookbook file: id_rsa.txt<br>
and that same SSL key should also be configured with Github - with access to the same repo that is listed as the attribute: git_repo<br>

and that the following SSL certificate file will be replaced by your actual SSL certificate content:<br>
<br>
mydomain.com.ca<br>
mydomain.com.crt<br>
mydomain.com.key<br>


Authors
-------------------
Authors: Phil Hendren (Github: phendren) - gocodeyourself@gmail.com
