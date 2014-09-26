include_recipe 'vagrant_env::yum-repos'

package "screen" do
  action :install
end
