bash 'add mysql community' do
  user 'root'
  code <<-EOC
    rpm -ivh #{node[:mysql][:rpm_path]}
  EOC
end

# mysql-devel is necessary for "rails -d mysql"
%w{mysql-community-server mysql-community-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/my.cnf" do
  source "mysql-server/my.cnf.erb"
  owner "root"
  group "root"
  mode 0644
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
