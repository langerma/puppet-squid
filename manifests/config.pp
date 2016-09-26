# == Class squid::config
#
# This class is called from squid for service config.
#
class squid::config {
  file {$::squid::config_file:
    ensure       => 'present',
    content      => template('squid/squid.conf.erb'),
    validate_cmd => $::squid::config_validate_cmd,
    notify       => Service[$::squid::service_name],
  }
  if $::squid::rotateint =~ /(hourly|daily)|(weekly|monthly)/ {
    file {$::squid::logrotate_file:
      ensure  => 'present',
      content => template('squid/logrotate.squid.erb'),
    }
  }
}
