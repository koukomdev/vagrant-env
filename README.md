vagrant-env  
===========  

prepare vagrant environment  

料理サプリ開発環境を構築する  
bundle vagrantは必要  

attributes/default.rb内でhomesickについて指定しています  
デフォルトで https://github.com/koukomdev/dot-files にしてるのでご自身のhomesickリポジトリを指定して下さい  
vm内で作業予定が無いならrm recipes/rbenv_homesick.rbして頂けると。。。  

$ bundle --path vendor/bundle  
$ bundle exec berks install  
$ vagrant up vagrant-env  
$ vagrant ssh-config vagrant-env --host vagrant-env >> ~/.ssh/config  
$ bundle exec knife solo prepare vagrant-env  
$ bundle exec knife solo cook vagrant-env  
$ vagrant ssh vagrant-env  
