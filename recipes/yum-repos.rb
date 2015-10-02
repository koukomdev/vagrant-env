# coding: utf-8

# CA証明書が古すぎてepelへの接続に失敗していたので更新する
package "ca-certificates" do
  action :upgrade
end

include_recipe "yum-epel"
include_recipe "yum-repoforge"
