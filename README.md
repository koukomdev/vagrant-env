vagrant_env
===========

prepare vagrant environment  

とりあえずrailsが動く状態にする目的  
bundle vagrantは必要

ruby 2.0.0だとberkshelfが動かない?  
他の理由かも…  

$ bundle --path vendor/bundle  
$ bundle exec berks install  
$ vagrant up cent6  
$ vagrant ssh-config cent6 --host cent6 >> ~/.ssh/config  
$ bundle exec knife solo start  
$ bundle exec knife solo cook cent6  
$ vagrant ssh cent6  
