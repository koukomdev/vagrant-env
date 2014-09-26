include_recipe 'git::source'

package "git" do
  action :remove
end

file "/etc/profile.d/git.sh" do
  owner "root"
  group "root"
  mode "644"
  action :create
  content <<-EOS
    alias git=#{node[:git][:prefix]}/bin/git
  EOS
end
