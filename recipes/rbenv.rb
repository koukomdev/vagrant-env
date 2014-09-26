include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby node[:rbenv][:version] do
  ruby_version node[:rbenv][:version]
  global true
end
