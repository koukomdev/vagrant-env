bash "download_phantomJS" do
  code <<-EOC
    cd /usr/local/src
    wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2 -O phantomjs-1.9.8-linux-x86_64.tar.bz2
    tar jxvf phantomjs-1.9.8-linux-x86_64.tar.bz2
    mv phantomjs-1.9.8-linux-x86_64 phantomjs
    cd phantomjs
  EOC
end

bash "alias_phantomJS" do
  code <<-EOC
    cd /usr/local/src/phantomjs
    ln -sf `pwd`/bin/phantomjs /usr/local/bin/phantomjs
  EOC
end

bash "japanese_correspondence_phantomJS" do
  code <<-EOC
    sudo yum -y groupinstall "Japanese Support"
  EOC
end

# phantomJSの日本語化対応
template "/etc/fonts/fonts.conf" do
  source "font/fonts.conf"
  owner "root"
  group "root"
  mode 0644
end

# centosの言語設定をusにしてwebfontを読めるようにする
template "/etc/sysconfig/i18n" do
  source "sysconfig/i18n"
  owner "root"
  group "root"
  mode 0644
end
