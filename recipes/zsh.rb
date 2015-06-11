include_recipe 'remi-env::yum-repos'

package "zsh" do
  action :install
end

bash "chsh" do
  code <<-EOS
    chsh -s `which zsh` #{node[:zsh][:user]}
  EOS
  only_if do
    /(yes|^y)/i =~ node[:zsh][:chsh]
  end
end
