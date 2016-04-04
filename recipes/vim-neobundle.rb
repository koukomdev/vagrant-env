include_recipe 'vagrant-env::vim'

default_user = data_bag_item("users", "default")

directory "#{default_user['home']}/.vim" do
  user default_user["name"]
  group default_user["name"]
  action :create
end

git "#{default_user['home']}/.vim/neobundle.vim.git" do
  repository node[:vim][:neobundle][:repo]
  action :sync
end

execute "neobundle install" do
  command "su #{default_user["name"]} -l -c \"#{default_user['home']}/.vim/neobundle.vim.git/bin/neoinstall 1>/dev/null 2>&1\""
  only_if do
    /(yes|^y)/i =~ node[:vim][:neobundle][:exec]
  end
end
