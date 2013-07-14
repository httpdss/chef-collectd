#
# Cookbook Name:: collectd
# Recipe:: collectd_web
#
# Copyright 2010, Atari, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "collectd"

%w(libhtml-parser-perl liburi-perl librrds-perl libjson-perl).each do |name|
  package name
end

directory node[:collectd][:collectd_web][:path] do
  owner "root"
  group "root"
  mode "755"

  not_if do
    File.directory? node[:collectd][:collectd_web][:path]
  end
end

bash "install_collectd_web" do
  user "root"
  cwd node[:collectd][:collectd_web][:path]
  not_if do
    File.exists?(File.join(node[:collectd][:collectd_web][:path], "index.html"))
  end
  code <<-EOH
    wget --no-check-certificate -O collectd-web.tar.gz https://github.com/httpdss/collectd-web/tarball/master
    tar --strip-components=1 -xzf collectd-web.tar.gz
    rm collectd-web.tar.gz
  EOH
end

# <Plugin "rrdtool">
#   DataDir "/var/lib/collectd/rrd"
#   CacheFlush 120
#   WritesPerSecond 50
# </Plugin>

collectd_plugin "rrdtool" do
  options :data_dir => '/var/lib/collectd/rrd',
          :cache_flush => 120,
          :writes_per_second => 50
end
