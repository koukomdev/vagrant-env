vagrant_env
===========

prepare vagrant environment

とりあえずrailsが動く状態にする目的
bundle vagrantは必要

$ bundle --path vendor/bundle
$ bundle exec berks install
$ vagrant ssh-config cent6 --host cent6 >> ~/.ssh/config
$ vagrant up cent6
$ bundle exec knife solo start
$ bundle exec knife solo cook cent6
$ vagrant ssh cent6
