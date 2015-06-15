::Chef::Resource.send(:include, SolrHelper)

action :default do
  Chef::Log.info "solr_starter prepared"
end

action :restart do
  Chef::Log.info "solr_starter restart"

  service "restart_solr" do
    service_name "solr"
    action :restart
    notifies :create, "ruby_block[wait_until_bootup]", :immediately
  end

  ruby_block "wait_until_bootup" do
    block do
      solr_uri = "http://#{node[:solr][:host]}:#{node[:solr][:port]}/solr/"
      wait_until_bootup(solr_uri)
    end
  end

  Chef::Log.info "solr_starter restart finished"
  @new_resource.updated_by_last_action(true)
end
