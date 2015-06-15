package "redis" do
  action :install
end

service "redis" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
