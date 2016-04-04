include_recipe 'vagrant-env::yum-repos'

package "lv" do
    action :install
end
