bash 'add mysql community' do
  user 'root'
  code <<-EOC
    rpm -ivh #{node[:mysql][:rpm_path]}
  EOC
end

# mysql-devel is necessary for "rails -d mysql"
%w{mysql-community-server mysql-community-devel}.each do |pkg|
  template "/etc/my.cnf" do
    source "mysql-server/my.cnf.erb"
    owner "root"
    group "root"
    mode 0644
  end

  template "/usr/share/mysql/charsets/Index.xml" do
    source "mysql-server/charsets.cnf.erb"
    owner "root"
    group "root"
    mode 0644
  end

  package pkg do
    action :install
    notifies :create, resources( :template => "/etc/my.cnf" )
    notifies :create, resources( :template => "/usr/share/mysql/charsets/Index.xml" )
  end
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
