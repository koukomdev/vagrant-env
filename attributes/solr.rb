default["solr"]["mysql-connector"]["version"] = "5.1.30"
default["solr"]["mysql"]["host"] = "localhost"
default["solr"]["mysql"]["port"] = "3306"
default["solr"]["mysql"]["user"] = "root"
default["solr"]["mysql"]["pass"] = ""
default["solr"]["mysql"]["db"]   = "remi_development"

default["solr"]["cores"] = %w/
  ingredients
  genres
  recipes
/

default["solr"]["core"]["default"]["name"]                = "collection1"
default["solr"]["core"]["default"]["delete"]              = "true"
default["solr"]["core"]["default"]["delete_index"]        = "true"
default["solr"]["core"]["default"]["delete_data_dir"]     = "true"
default["solr"]["core"]["default"]["delete_instance_dir"] = "true"

default["solr"]["cron"]["delta_duration"] = "5"

default["solr"]["replication"]["solrconfig"]    = node[:solr][:replication][:conf_selector][node[:opsworks][:instance][:layers][0]] rescue 'solrconfig_master'
default["solr"]["replication"]["master_host"]   = "localhost"
default["solr"]["replication"]["master_port"]   = "8983"
default["solr"]["replication"]["poll_interval"] = "00:00:30"
default["solr"]["replication"]["conf_files"]    = ""
