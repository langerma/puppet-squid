# == Class: squid
#
# Full description of class squid here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class squid (
  $package_name                  = $::squid::params::package_name,
  $service_name                  = $::squid::params::service_name,
  $reload_cmd                    = $::squid::params::reload_cmd,
  $config_file                   = $::squid::params::config_file,
  $config_validate_cmd           = $::squid::params::config_validate_cmd,
  $log_dir                       = $::squid::params::log_dir,
  $logrotate_file                = $::squid::params::logrotate_file,
  $rotateint                     = '',
  $rotatecnt                     = 3,
  $ssl_ports                     = [443],
  $safe_ports                    = ['80','21','443','70','210','1025-65535','280','488','591','777'],
  $acl                           = [],
  $http_access                   = [],
  $icp_access                    = [],
  $http_port                     = [3128],
  $https_port                    = [],
  $tcp_outgoing_address          = [],
  $cache_dir                     = [],
  $cache_peer                    = [],
  $cache_peer_access             = [],
  $hierarchy_stoplist            = 'cgi-bin ?',
  $coredump_dir                  = $::squid::params::coredump_dir,
  $maximum_object_size_in_memory = '512 KB',
  $maximum_object_size           = '4096 KB',
  $cache_mgr                     = 'root',
  $client_persistent_connections = 'on',
  $server_persistent_connections = 'on',
  $visible_hostname              = $::fqdn,
  $unique_hostname               = $::fqdn,
  $forwarded_for                 = 'on',
  $via                           = 'on',
  $ftp_user                      = "squid@${::fqdn}",
  $dns_nameservers               = undef,
  $access_log                    = ["${log_dir}/access.log squid"],
  $cache_mem                     = '256 MB',
  $cache_store_log               = 'none',
  $cache_log                     = "${log_dir}/cache.log",
  $cache                         = [],
  $refresh_patterns              = [],
  $always_direct                 = [],
  $never_direct                  = [],
  $addon_config                  = [],

) inherits ::squid::params {

  # validate parameters here

  class {'::squid::install':} ->
  class {'::squid::config':} ->
  class {'::squid::service':} ->
  Class['::squid']
}
