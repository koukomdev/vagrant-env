include_recipe 'vagrant_env::rbenv'

rbenv_gem "bundler" do
  ruby_version node[:rbenv][:version]
end
