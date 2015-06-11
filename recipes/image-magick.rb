# Cookbook Name:: prepare-env
# Recipe:: image-magick
#
# Licensed under the Apache License, Version 2.0 (the "License");
#

include_recipe 'remi-env::yum-repos'

%w{ImageMagick ImageMagick-devel}.each do |pkg|
  package pkg do
    action :install
  end
end
