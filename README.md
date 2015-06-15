remi-env  
===========  

prepare vagrant environment  

料理サプリ開発環境を構築する  
bundle vagrantは必要  

attributes/default.rb内でhomesickについて指定しています  
デフォルトでhttps://github.com/koukomdev/dot-filesにしてるのでご自身のhomesickリポジトリを指定して下さい  
vm内で作業予定が無いならrm recipes/rbenv_homesick.rbして頂けると。。。  

$ bundle --path vendor/bundle  
$ bundle exec berks install  
$ vagrant up remi-env  
$ vagrant ssh-config remi-env --host remi-env >> ~/.ssh/config  
$ bundle exec knife solo prepare remi-env  
$ bundle exec knife solo cook remi-env  
$ vagrant ssh remi-env  
