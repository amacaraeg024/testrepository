include_recipe 'firewall'
include_recipe 'nginx'

template '/etc/nginx/sites-available/jenkins' do
  source 'nginx-site.erb'
  action :create
end

link '/etc/nginx/sites-enabled/jenkins' do
  to '/etc/nginx/sites-available/jenkins'
end

firewall_rule 'http' do
  port 80
  command :allow
  notifies :restart, 'service[nginx]'
end

yum_repository 'jenkins' do
  description 'Jenkins repo'
  baseurl 'http://pkg.jenkins-ci.org/redhat-stable'
  gpgkey 'http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key'
  action :create
  only_if { node['platform_family'] == 'rhel' }
end

package 'java-1.7.0-openjdk.x86_64' do
  action :install
end

package 'jenkins' do
  action :install
end

service "jenkins" do
  action :start
end

package 'python-pip' do
  action :install
end

bash 'install awscli' do
  code <<-EOH
    pip install awscli
    EOH
end

bash 'set selinux permissive' do
  code <<-EOH
    setenforce 0
    EOH
end
