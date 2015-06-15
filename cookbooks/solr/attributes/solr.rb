### solr
default['solr']['version']     = '4.7.1'
default['solr']['url']         = "https://archive.apache.org/dist/lucene/solr/#{node['solr']['version']}/solr-#{node['solr']['version']}.tgz"
default['solr']['install_dir'] = "/opt/solr-#{node['solr']['version']}/solr-#{node['solr']['version']}"
default['solr']['data_dir']    = "#{node['solr']['install_dir']}/example/solr/"
default['solr']['log_dir']     = "#{node['solr']['install_dir']}/example/logs/"

default['solr']['host'] = "localhost"
default['solr']['port'] = "8983"

default['solr']['jvm']['xms'] = "128m"
default['solr']['jvm']['xmx'] = "512m"
default['solr']['jvm']['xss'] = "256k"
default['solr']['jvm']['gc_log'] = "#{node['solr']['log_dir']}/gc_info.log"

# JVM 起動オプションの -XX:hogehoge を指定
# -XX: の右の部分のみ指定すること
default['solr']['jvm']['xx_options'] = %w/
  +UseConcMarkSweepGC
  +CMSParallelRemarkEnabled
  +UseParNewGC
  +PrintGCTimeStamps
  +PrintGCDetails
  +PrintClassHistogram
  +HeapDumpOnOutOfMemoryError
  NewRatio=2
  SurvivorRatio=2
  PermSize=64m
  MaxPermSize=64m
  MaxTenuringThreshold=80
  TargetSurvivorRatio=80
/
