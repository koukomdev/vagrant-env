include_recipe 'vagrant-env::yum-repos'

package "screen" do
  action :install
end
