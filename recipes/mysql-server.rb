include_recipe 'vagrant_env::yum-repos'

# mysql-devel is necessary for "rails -d mysql"
%w{mysql-server mysql-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
