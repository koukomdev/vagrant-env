include_recipe 'vagrant_env::vim-neobundle'

default_user = data_bag_item("users", "default")

execute "compile vimproc" do
  command "su #{default_user["name"]} -l -c \"cd #{default_user['home']}/.bundle/vimproc && make 1>/dev/null 2>&1\""
  only_if do
    /(yes|^y)/i =~ node[:vim][:vimproc][:compile]
  end
end
