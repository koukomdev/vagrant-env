remi-env  
===========  

prepare vagrant environment  

料理サプリ開発環境を構築する  
bundle vagrantは必要  

$ bundle --path vendor/bundle  
$ bundle exec berks install  
$ vagrant up remi-env  
$ vagrant ssh-config remi-env --host remi-env >> ~/.ssh/config  
$ bundle exec knife solo prepare remi-env  
$ bundle exec knife solo cook remi-env  
$ vagrant ssh remi-env  
