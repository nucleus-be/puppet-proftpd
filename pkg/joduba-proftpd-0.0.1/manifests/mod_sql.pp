# == Class: proftpd::mod_sql
#
# Install, enable and configure a proftpd::mod_sql
#
# === Parameters
#
# [*ensure*]
#   The ensure of the apache package to install
#   Could be "latest", "installed" or a pinned verison
#
# [*confdir*]
#   path to the proftpd configuration folder
#
# [*package_name*]
#   The package name for proftpd package
#
# [*mod_package_name*]
#   The package name for proftpd mod-sql package
#
# [*service_name*]
#   The service name for proftpd 
#
# [*template*]
#   proftpd.conf erb template file path
#
# [*sqlBackend*]
#   Corresponds to proFtpd SQLBackend configuration option
#
# [*sqlAuthTypes*]
#   Corresponds to proFtpd SQLAuthTypes configuration option
#
# [*sqlAuthenticate*]
#   Corresponds to proFtpd SQLAuthenticate configuration option
#
# [*sqldbname*]
#   name of the DB where containing the user
#
# [*sqldbhost*]
#   name of the host server where to connect
#
# [*sqldbuser*]
#   name of the user to connect to DB containing the user
#
# [*sqldbpass*]
#   password to be used to connect with DB containing the user
#
# [*sqlUserPrimaryKey*]
#   Corresponds to proFtpd SQLUserPrimaryKey configuration option
#
# [*sqlUserInfo*]
#   Corresponds to proFtpd SQLUserInfo configuration option
#
# [*sqlGroupInfo*]
#   Corresponds to proFtpd SQLGroupInfo configuration option
#
# [*sqlDefaultGID*]
#   Corresponds to proFtpd SQLDefaultGID configuration option
#
# [*sqlDefaultUID*]
#   Corresponds to proFtpd SQLDefaultUID configuration option
#
# [*sqlMinID*]
#   Corresponds to proFtpd SQLMinID configuration option
#
# [*sqlLogUpdatecountQuery*]
#   SQL query to be used to update the # of login counts.
#
# [*sqlLogModifiedQuery*]
#   SQL query to be used to update the last modified on delete and upload files.
#
# [*directives*]
#   Directives defined in this hash will be added to the bottom of 
#	the configuration file in the form of "key value"
#
# === Database Structure
#
/*
CREATE TABLE IF NOT EXISTS `ftpgroup` (
  `groupname` varchar(16) COLLATE utf8_general_ci NOT NULL,
  `gid` smallint(6) NOT NULL DEFAULT '5500',
  `members` varchar(16) COLLATE utf8_general_ci NOT NULL,
  KEY `groupname` (`groupname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='ProFTP group table';

CREATE TABLE IF NOT EXISTS `ftpuser` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `passwd` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `uid` smallint(6) NOT NULL DEFAULT '5500',
  `gid` smallint(6) NOT NULL DEFAULT '5500',
  `homedir` varchar(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `shell` varchar(16) COLLATE utf8_general_ci NOT NULL DEFAULT '/sbin/nologin',
  `count` int(11) NOT NULL DEFAULT '0',
  `accessed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid` (`userid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='ProFTP user table';

*/
# === Variables
#
# No variables
#
# === Examples
#
#  include proftpd::mod_sql
#  class { 'proftpd::mod_sql':
#	sqldbhost => "localhost",
#	sqldbname => "ftpusers",
#	sqldbuser => "ftpusers",
#	sqldbpass => "mypassword",
#  }
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
class proftpd::mod_sql (
  $confdir                 = $::proftpd::params::confdir,
  $package_name            = $::proftpd::params::package_name,
  $mod_package_name        = $::proftpd::params::package_name_mod_sql,
  $service_name            = $::proftpd::params::service_name,
  $template                = 'proftpd/sql.conf.erb',
  # sql.conf options
  $sqlBackend				= 'mysql',
  $sqlAuthTypes				= 'OpenSSL Crypt',
  $sqlAuthenticate         	= 'users groups',
  $sqldbname				= '',
  $sqldbhost				= '',
  $sqldbuser				= '',
  $sqldbpass				= '',
  $sqlUserPrimaryKey		= 'id',
  $sqlUserInfo     			= 'ftpuser userid passwd uid gid homedir shell',
  $sqlGroupInfo				= 'ftpgroup groupname gid members',
  $sqlDefaultGID   			= 33,
  $sqlDefaultUID   			= 33,
  $sqlMinID     			= 500,
  $sqlLogUpdatecountQuery	= 'updatecount UPDATE "count=count+1, accessed=now() WHERE userid=\'%u\'" ftpuser',
  $sqlLogModifiedQuery		= 'modified UPDATE "modified=now() WHERE userid=\'%u\'" ftpuser',
  $sqlLogFile 				= "/var/log/proftpd/sql.log",

  $directives              = {},
) inherits ::proftpd::params {

	package { $mod_package_name: 
		ensure => installed,
		require => Package[$package_name],
	}
	
	file_line {'Load SQL module':
	    path => "${confdir}/modules.conf",
	    line => "LoadModule mod_sql.c\nLoadModule mod_sql_mysql.c",
	}
	
	file { "${confdir}/conf.d/sql.conf":
		require => Package[$mod_package_name],
		content => template($template),
	    notify  => Service[$service_name],
	    ensure  => present, 
	}


}

