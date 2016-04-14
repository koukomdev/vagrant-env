include_recipe 'vagrant-env::vim'

default_user = data_bag_item("users", "default")

%W[
  #{default_user['home']}/.vim
  #{default_user['home']}/.vim/bundle
].each do |path|
  directory path do
    user default_user["name"]
    group default_user["name"]
    action :create
  end
end

git "#{default_user['home']}/.vim/bundle/neobundle.vim" do
  repository node[:vim][:neobundle][:repo]
  action :sync
end

execute "neobundle install" do
  command "su #{default_user["name"]} -l -c \"#{default_user['home']}/.vim/bundle/neobundle.vim/bin/neoinstall 1>/dev/null 2>&1\""
  only_if do
    /(yes|^y)/i =~ node[:vim][:neobundle][:exec]
  end
end
