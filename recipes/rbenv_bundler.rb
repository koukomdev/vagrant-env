include_recipe 'vagrant-env::rbenv'

rbenv_gem "bundler" do
  ruby_version node[:rbenv][:version]
end
