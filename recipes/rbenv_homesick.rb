include_recipe 'remi-env::rbenv'
include_recipe 'remi-env::git'

rbenv_gem "homesick" do
  ruby_version node[:rbenv][:version]
end

rbenv_path = "#{node[:rbenv][:root_path]}/shims"

bash "homesick" do
  user node[:homesick][:user]
  environment "HOME" => "/home/#{node[:homesick][:user]}"

  code <<-EOS
    #{rbenv_path}/homesick clone #{node[:homesick][:repo]}
    #{rbenv_path}/homesick symlink #{node[:homesick][:castle]}
  EOS
end
