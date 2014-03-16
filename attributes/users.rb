#
# Cookbook Name:: rackspace_jboss
# Attributes:: users
#
# Copyright 2014, Rackspace, US Inc.
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

# These are arrays that contain an array of a user and a hash, i.e.:
# [%w(<user1> <hash1>), %w(<user2> <hash2>), %w(...etc)]
# To find the hash for a given user, either look it up in the
# mgmt-users.properties and/or application-users.properties file on an
# existing system, or run the following from a bash command line:
# python -c "import hashlib; print(hashlib.md5(b'<username>:ManagementRealm:<password>').hexdigest())"
# python -c "import hashlib; print(hashlib.md5(b'<username>:ApplicationRealm:<password>').hexdigest())"
default['rackspace_jboss']['config']['mgmt-users']                = []
default['rackspace_jboss']['config']['application-users']         = []
