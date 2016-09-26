# == Class squid::service
#
# This class is meant to be called from squid.
# It ensure the service is running.
#
class squid::service {
  service {$::squid::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    restart    => $::squid::reload_cmd,
  }
}
