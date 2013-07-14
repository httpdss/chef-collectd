#
# Cookbook Name:: collectd
# Recipe:: plugins
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


# <Plugin "df">
#   Device "/dev/hda1"
#   MountPoint "/home"
#   FSType "ext3"
#   IgnoreSelected false
#   # Since 4.9
#   ReportReserved false
#   ReportInodes false
# </Plugin>

collectd_plugin "df" do
  options :device => '/vagrant',
          :mount_point => '/vagrant',
          :f_s_type => 'vboxsf'
end