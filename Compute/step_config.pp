# Copyright 2014 Red Hat, Inc.
# All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

# Common config, from tripleo-heat-templates/puppet/manifests/overcloud_common.pp
# The content of this file will be used to generate
# the puppet manifests for all roles, the placeholder
# Compute will be replaced by 'controller', 'blockstorage',
# 'cephstorage' and all the deployed roles.

if hiera('step') >= 4 {
  hiera_include('Compute_classes', [])
}

$package_manifest_name = join(['/var/lib/tripleo/installed-packages/overcloud_Compute', hiera('step')])
package_manifest{$package_manifest_name: ensure => present}

# End of overcloud_common.pp

include ::tripleo::trusted_cas
include ::tripleo::profile::base::neutron::plugins::ml2

include ::tripleo::profile::base::docker

include ::tripleo::profile::base::kernel
include ::tripleo::profile::base::database::mysql::client
include ::tripleo::profile::base::time::ntp
include ::tripleo::profile::base::snmp

include ::tripleo::profile::base::sshd

include ::timezone
include ::tripleo::firewall

include ::tripleo::packages

include ::tripleo::profile::base::tuned