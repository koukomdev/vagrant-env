include_recipe 'remi-env::yum-repos'

package "screen" do
  action :install
end
