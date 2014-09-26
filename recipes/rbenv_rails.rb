include_recipe 'vagrant_env::rbenv'

ruby_block "resolv.conf" do
  block do
    resolver = "/etc/resolv.conf"
    File.open(resolver, "r+") {|f|
      option = "options single-request-reopen"
      f.puts(option) unless f.readlines.any? {|l|
        /#{option}/ =~ l
      }
    }
  end
  only_if do platform?("centos") end
end

rbenv_gem "rails" do
  ruby_version node[:rbenv][:version]
end
