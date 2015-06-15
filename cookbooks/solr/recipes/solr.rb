# Cookbook Name:: solr
# Recipe:: solr
#
# Licensed under the Apache License, Version 2.0 (the "License");
#

include_recipe 'solr::default'

# setting mysql connector
cookbook_file "#{node[:solr][:install_dir]}/dist/mysql-connector-java-#{node[:solr][:"mysql-connector"][:version]}-bin.jar" do
  source "mysql-connector-java-#{node[:solr][:"mysql-connector"][:version]}-bin.jar"
  action :create_if_missing
  owner "root"
  group "root"
  mode 0644
end

# setting core
solr_data_dir = node[:solr][:data_dir]
default_core  = node[:solr][:core][:default][:name]
cores         = node[:solr][:cores]

cores.each do |core|
  ruby_block "copy core #{core} from #{default_core}" do
    block do
      FileUtils.copy_entry("#{solr_data_dir}/#{default_core}", "#{solr_data_dir}/#{core}")
    end
  end

  # core.properties
  template "#{solr_data_dir}/#{core}/core.properties" do
    source "cores/#{core}/core.properties"
    owner "root"
    group "root"
    mode 0644
  end

  # schema.xml
  template "#{solr_data_dir}/#{core}/conf/schema.xml" do
    source "cores/#{core}/schema.xml"
    owner "root"
    group "root"
    mode 0644
  end

  # solrconfig.xml
  template "#{solr_data_dir}/#{core}/conf/solrconfig.xml" do
    source "cores/common/#{node[:solr][:replication][:solrconfig]}.xml"
    owner "root"
    group "root"
    mode 0644
    variables({
      :master_host   => node[:solr][:replication][:master_host],
      :master_port   => node[:solr][:replication][:master_port],
      :poll_interval => node[:solr][:replication][:poll_interval],
      :conf_files    => node[:solr][:replication][:conf_files],
      :core          => core,
    })
  end

  # db-data-config.xml
  template "#{solr_data_dir}/#{core}/conf/db-data-config.xml" do
    source "cores/#{core}/db-data-config.xml"
    owner "root"
    group "root"
    mode 0644
    variables({
      :host => node[:solr][:mysql][:host],
      :port => node[:solr][:mysql][:port],
      :user => node[:solr][:mysql][:user],
      :pass => node[:solr][:mysql][:pass],
      :db   => node[:solr][:mysql][:db],
    })
  end

  # empty elevate.xml
  template "#{solr_data_dir}/#{core}/conf/elevate.xml" do
    source "elevate.xml"
    owner "root"
    group "root"
    mode 0644
  end
end

solr_starter 'restart' do
  action :restart
end

# delete default core
default_core = node[:solr][:core][:default][:name]

ruby_block "delete default core '#{default_core}'" do
  block do
    `curl "http://#{node[:solr][:host]}:#{node[:solr][:port]}/solr/admin/cores?action=UNLOAD&name=#{default_core}&deleteIndex=#{node[:solr][:core][:default][:delete_index]}&deleteDataDir=#{node[:solr][:core][:default][:delete_data_dir]}&deleteInstanceDir=#{node[:solr][:core][:default][:delete_instance_dir]}"`
  end
  only_if do
    /(yes|^y|true|^t)/i =~ node[:solr][:core][:default][:delete]
  end
end

solr_starter 'restart' do
  action :restart
end
