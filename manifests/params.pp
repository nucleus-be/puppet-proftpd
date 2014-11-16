# Class: proftpd::params
#
# === Authors
#
# Joduba - Jordi Duran i Batidor http://www.joduba.com
# Iwith.org Foundation http://www.iwith.org/en/
#
# === Copyright
#
# Copyright 2014 Joduba & Iwith.org, unless otherwise noted.
#
class proftpd::params {

  $package_name = 'proftpd'
  $service_name = 'proftpd'
  $package_name_mod_sql = 'proftpd-mod-mysql'

  case $::operatingsystem {
    default: {
      $confdir = '/etc/proftpd'
    }
  }

}

