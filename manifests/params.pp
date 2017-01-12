# == Class squid::params
#
# This class is meant to be called from squid.
# It sets variables according to platform.
#
class squid::params {
  case $::osfamily {
    'RedHat': {
      if 0 + $::operatingsystemmajrelease >= 7 {
        $package_name        = 'squid'
        $service_name        = 'squid'
        $reload_cmd          = 'systemctl reload squid'
        $config_file         = '/etc/squid/squid.conf'
        $config_validate_cmd = '/usr/sbin/squid -k parse -f %'
        $coredump_dir        = '/var/spool/squid'
        $log_dir             = '/var/log/squid'
        $logrotate_file      = '/etc/logrotate.d/squid'
      } else {
        fail("${::operatingsystem} ${::operatingsystemmajrelease} not supported")
      }
    }
    'FreeBSD': {
      $package_name        = 'squid'
      $service_name        = 'squid'
      $reload_cmd          = 'service squid reload'
      $config_file         = '/usr/local/etc/squid/squid.conf'
      $config_validate_cmd = '/usr/local/sbin/squid -k parse -f %'
      $coredump_dir        = '/var/squid'
      $log_dir             = '/var/log/squid'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
