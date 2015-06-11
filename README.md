remi-env
===========

prepare vagrant environment

料理サプリ開発環境を構築する
bundle vagrantは必要

$ bundle --path vendor/bundle
$ bundle exec berks install
$ vagrant up cent6
$ vagrant ssh-config cent6 --host cent6 >> ~/.ssh/config
$ bundle exec knife solo prepare cent6
$ bundle exec knife solo cook cent6
$ vagrant ssh cent6
