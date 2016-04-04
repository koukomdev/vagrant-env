include_recipe 'vagrant-env::nginx'

template "/etc/nginx/conf.d/default.conf" do
  source "nginx-rails/default.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, 'service[nginx]'
end
