#!/bin/bash

apt-get update
apt-get install -y ruby ruby-1.8-dev build-essential wget libruby-extras libruby1.8-extras
cd /tmp
wget http://production.cf.rubygems.org/rubygems/rubygems-1.6.2.tgz
tar zxf rubygems-1.6.2.tgz
cd rubygems-1.6.2
ruby setup.rb --no-format-executable

gem update --no-rdoc --no-ri
gem install ohai --no-rdoc --no-ri
gem install chef --no-rdoc --no-ri


chef-solo -c /etc/chef/solo.rb -j /etc/chef/chef.json -r http://s3.amazonaws.com/chef-solo/bootstrap-latest.tar.gz  > /tmp/chef_solo.log 2>&1
sudo -u ubuntu /home/ubuntu/setup_environment > /tmp/setup_environment.log 2>&1

