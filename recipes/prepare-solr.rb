# Cookbook Name:: remi-env
# Recipe:: prepare-solr
#
# Licensed under the Apache License, Version 2.0 (the "License");
#

include_recipe 'remi-env::java'

src_filename = ::File.basename(node['solr']['url'])
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"
extract_path = "/opt/solr-#{node['solr']['version']}"

remote_file src_filepath do
  source node['solr']['url']
  action :create_if_missing
end

bash 'unpack_solr' do
  cwd ::File.dirname(src_filepath)
  code <<-EOH
    mkdir -p #{extract_path}
    tar xzf #{src_filename} -C #{extract_path}
  EOH
  not_if { ::File.exists?(extract_path) }
end

directory node['solr']['data_dir'] do
  owner 'root'
  group 'root'
  action :create
end

template '/var/lib/solr.start' do
  source 'solr.start.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    :solr_dir       => "#{extract_path}/solr-#{node['solr']['version']}",
    :solr_home      => node['solr']['data_dir'],
    :solr_port      => node['solr']['port'],
    :jvm_xms        => node['solr']['jvm']['xms'],
    :jvm_xmx        => node['solr']['jvm']['xmx'],
    :jvm_xss        => node['solr']['jvm']['xss'],
    :jvm_gc_log     => node['solr']['jvm']['gc_log'],
    :jvm_xx_options => node['solr']['jvm']['xx_options'].map{|opt| "-XX:#{opt}"}.join(" "),
    :pid_file       => '/var/run/solr.pid',
    :log_file       => '/var/log/solr.log'
  )
end

template '/etc/init.d/solr' do
  source 'initd.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service 'solr' do
  supports :restart => true, :status => true
  action [:enable, :start]
end
