# == Class: proftpd
#
# Install, enable and configure a proftpd FTP server instance.
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
# [*service_name*]
#   The service name for proftpd 
#
# [*template*]
#   proftpd.conf erb template file path
#
# [*useIPv6*]
#   Corresponds to proFtpd UseIPv6 configuration option
#
# [*identLookups*]
#   Corresponds to proFtpd IdentLookups configuration option
#
# [*identLookups*]
#   Corresponds to proFtpd IdentLookups configuration option
#
# [*serverName*]
#   Corresponds to proFtpd ServerName configuration option
#
# [*serverType*]
#   Corresponds to proFtpd ServerType configuration option
#
# [*displayConnect*]
#   Corresponds to proFtpd DisplayConnect configuration option
#
# [*displayConnectContent*]
#   Content of DisplayConnect file
#
# [*deferWelcome*]
#   Corresponds to proFtpd DeferWelcome configuration option
#
# [*multilineRFC2228*]
#   Corresponds to proFtpd MultilineRFC2228 configuration option
#
# [*defaultServer*]
#   Corresponds to proFtpd DefaultServer configuration option
#
# [*showSymlinks*]
#   Corresponds to proFtpd ShowSymlinks configuration option
#
# [*timeoutNoTransfer*]
#   Corresponds to proFtpd TimeoutNoTransfer configuration option
#
# [*timeoutStalled*]
#   Corresponds to proFtpd TimeoutStalled configuration option
#
# [*timeoutIdle*]
#   Corresponds to proFtpd TimeoutIdle configuration option
#
# [*displayLogin*]
#   Corresponds to proFtpd DisplayLogin configuration option
#
# [*displayChdir*]
#   Corresponds to proFtpd DisplayChdir configuration option
#
# [*listOptions*]
#   Corresponds to proFtpd ListOptions configuration option
#
# [*denyFilter*]
#   Corresponds to proFtpd DenyFilter configuration option
#
# [*defaultRoot*]
#   Corresponds to proFtpd DefaultRoot configuration option
#
# [*requireValidShell*]
#   Corresponds to proFtpd requireValidShell configuration option
#
# [*port*]
#   Corresponds to proFtpd Port configuration option
#
# [*maxInstances*]
#   Corresponds to proFtpd MaxInstances configuration option
#
# [*user*]
#   Corresponds to proFtpd User configuration option
#
# [*group*]
#   Corresponds to proFtpd Group configuration option
#
# [*umask*]
#   Corresponds to proFtpd Umask configuration option
#
# [*allowOverwrite*]
#   Corresponds to proFtpd AllowOverwrite configuration option
#
# [*persistentPasswd*]
#   Corresponds to proFtpd PersistentPasswd configuration option
#
# [*allowRetrieveRestart*]
#   Corresponds to proFtpd AllowRetrieveRestart configuration option
#
# [*allowStoreRestart*]
#   Corresponds to proFtpd AllowStoreRestart configuration option
#
# [*serverIdent*]
#   Corresponds to proFtpd ServerIdent configuration option
#
# [*authPAM*]
#   Corresponds to proFtpd AuthPAM configuration option
#
# [*dirFakeGroup*]
#   Corresponds to proFtpd DirFakeGroup configuration option
#
# [*dirFakeUser*]
#   Corresponds to proFtpd DirFakeUser configuration option
#
# [*useReverseDNS*]
#   Corresponds to proFtpd UseReverseDNS configuration option
#
# [*transferLog*]
#   Corresponds to proFtpd TransferLog configuration option
#
# [*systemLog*]
#   Corresponds to proFtpd SystemLog configuration option
#
# [*useLastlog*]
#   Corresponds to proFtpd UseLastlog configuration option
#
# [*quotaEngine*]
#   Corresponds to proFtpd QuotaEngine configuration option
#
# [*ratios*]
#   Corresponds to proFtpd Ratios configuration option
#
# [*delayEngine*]
#   Corresponds to proFtpd DelayEngine configuration option
#
# [*controlsEngine*]
#   Corresponds to proFtpd ControlsEngine configuration option
#
# [*controlsMaxClients*]
#   Corresponds to proFtpd ControlsMaxClients configuration option
#
# [*controlsLog*]
#   Corresponds to proFtpd ControlsLog configuration option
#
# [*controlsInterval*]
#   Corresponds to proFtpd ControlsInterval configuration option
#
# [*controlsSocket*]
#   Corresponds to proFtpd ControlsSocket configuration option
#
# [*adminControlsEngine*]
#   Corresponds to proFtpd AdminControlsEngine configuration option
#
# [*passivePorts*]
#   Corresponds to proFtpd PassivePorts configuration option
#
# [*masqueradeAddress*]
#   Corresponds to proFtpd MasqueradeAddress configuration option
#
# [*directives*]
#   Directives defined in this hash will be added to the bottom of 
#	the configuration file in the form of "key value"
#
# === Variables
#
# No variables
#
# === Examples
#
#  include proftpd
#  class { 'proftpd':
#	 serverName => "My FTPServer",
#	 timeoutNoTransfer => 900,
#	 timeoutStalled => 3600,
#	 timeoutIdle => 600,
#	 user => 'www-data',
#	 group => 'www-data',
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

class proftpd (
  $confdir                 = $::proftpd::params::confdir,
  $package_name            = $::proftpd::params::package_name,
  $service_name            = $::proftpd::params::service_name,
  $template                = 'proftpd/proftpd.conf.erb',
  # proftpd.conf options
  $useIPv6			       = 'on',
  $identLookups            = 'off',
  $serverName              = 'FTP Server',
  $serverType				= 'standalone',
  $displayConnect			= '/etc/proftpd/welcome.txt',
  $displayConnectContent	= "Welcome to ${serverName}",
  $deferWelcome				= 'off',
  $multilineRFC2228			= 'on',
  $defaultServer			= 'on',
  $showSymlinks				= 'on',
  $timeoutNoTransfer        = 600,
  $timeoutStalled           = 600,
  $timeoutIdle              = 1200,
  $displayLogin             = 'welcome.msg',
  $displayChdir             = '.message true',
  $listOptions              = '"-l"',
  $denyFilter               = '\*.*/',
  $defaultRoot              = '~',
  $requireValidShell        = 'off',
  $port                     = 21,
  $maxInstances             = 30,
  $user         			= 'proftpd',
  $group		            = 'nogroup',
  $umask                    = '022  022',
  $allowOverwrite           = 'on',
  $persistentPasswd			= 'off',
  $allowRetrieveRestart     = 'on',
  $allowStoreRestart        = 'on',
  $serverIdent              = 'on',
  $authPAM                  = 'off',
  $dirFakeGroup             = 'on',
  $dirFakeUser              = 'on',
  $useReverseDNS            = 'off',
  $transferLog 				= '/var/log/proftpd/xferlog',
  $systemLog   				= '/var/log/proftpd/proftpd.log',
  $useLastlog 				= 'off',
  $quotaEngine 				= 'off',
  $ratios	 				= 'off',
  $delayEngine				= 'on',
  $controlsEngine       	= 'off',
  $controlsMaxClients   	=  2,
  $controlsLog           	= '/var/log/proftpd/controls.log',
  $controlsInterval      	= 5,
  $controlsSocket        	= '/var/run/proftpd/proftpd.sock',
  $adminControlsEngine 		= 'off',
  $passivePorts				= '',
  $masqueradeAddress		= '',

  $directives              = {},
) inherits ::proftpd::params {

  package { $package_name: ensure => installed }

  service { $service_name:
    require   => Package[$package_name],
    enable    => true,
    ensure    => running,
    hasstatus => true,
  }

  file { "${displayConnect}":
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => "${displayConnectContent}",
  }

  file { "${confdir}/modules.conf":
    ensure  => $ensure,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    source  => 'puppet:///modules/proftpd/modules.conf',
  }

  file { "${confdir}/proftpd.conf":
    require => Package[$package_name],
    content => template($template),
    notify  => Service[$service_name],
  }

}

