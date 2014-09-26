include_recipe 'vagrant_env::yum-repos'

package "lv" do
    action :install
end
