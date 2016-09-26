# == Class squid::install
#
# This class is called from squid for install.
#
class squid::install {
  package {$::squid::package_name:
    ensure => present,
  }
}
