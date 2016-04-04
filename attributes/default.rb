### rbenv
default["rbenv"]["version"] = "2.0.0-p353"

### nginx
default["nginx"]["port"]     = "80"
default["nginx"]["upstream"] = "unicorn"

### rails
default["rails"]["server"]["socket"] = "unix:/tmp/unicorn.sock"

### vim-neobundle
default['vim']['neobundle']['exec']  = "yes"
default['vim']['neobundle']['repo']  = "https://github.com/Shougo/neobundle.vim"

### git
default['git']['prefix']   = "/usr/local"
default['git']['version']  = "2.6.4"
default['git']['checksum'] = "08e3ccdba87ca55140c8155a07e147f6c1cdd7b574690e960763b18474fd05ed"

### zsh
default['zsh']['chsh'] = "yes"
default['zsh']['user'] = "vagrant"

### homesick
default['homesick']['user']   = "vagrant"
default['homesick']['repo']   = "https://github.com/koukomdev/dot-files"
default['homesick']['castle'] = "dot-files"

### openjdk
default['openjdk']['version'] = "1.7.0"

### mysql
default['mysql']['rpm_path'] = "http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm"
