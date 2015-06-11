include_recipe 'remi-env::yum-repos'

package "lv" do
    action :install
end
