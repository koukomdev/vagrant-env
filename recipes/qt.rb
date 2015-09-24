template "/etc/yum.repos.d/qt.repo" do
  source "qt/qt.repo"
  owner "root"
  group "root"
  mode 0644
end

bash "install_qt48-qt-webkit-devel" do
  owner "root"
  code <<-EOC
    yum -y install qt48-qt-webkit-devel
  EOC
end

bash "alias_qt48-qt-webkit-devel" do
  owner "root"
  code <<-EOC
    ln -s /opt/rh/qt48/root/usr/include/QtCore/qconfig-64.h  /opt/rh/qt48/root/usr/include/QtCore/qconfig-x86_64.h
    source /opt/rh/qt48/enable
    export PATH=/opt/rh/qt48/root/usr/lib64/qt4/bin/${PATH:+:${PATH}}
  EOC
end
