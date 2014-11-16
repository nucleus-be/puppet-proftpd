# puppet-proftpd

## Overview

This module enables and configures a proftpd FTP server instance.

* `proftpd` : Enable and configure the proftpd FTP server
* `proftpd::mod_sql` : Enable and configure mod_sql module

## Examples

With all of the module's default settings :

```puppet
include proftpd
```

Tweaking a few settings (have a look at `manifests/init.pp` to know which
directives are supported as parameters) :

```puppet
class { 'proftpd':
	serverName => "My FTPServer",
	timeoutNoTransfer => 900,
	timeoutStalled => 3600,
	timeoutIdle => 600,
	user => 'www-data',
	group => 'www-data',
	passivePorts=> '60000 60199',
	displayConnectContent => 'WARNING!!!

This web services are running with UTF-8 encoding.
Please verify that any published text file is UTF-8 encoded
to avoid any displaying errors.

Thank you',

}
```

For any directives which aren't directly supported by the module, use the
additional `directives` hash parameter :

```puppet
class { 'proftpd':
  serverName => "My FTPServer",
  directives  => {
    'Include' => '/etc/proftpd/virtuals.conf',
  },
}
```

Mod_SQL requires connection information to be passed to the resource

```puppet
class { '::proftpd::mod_sql':
	sqldbhost => "localhost",
	sqldbname => "ftpusers",
	sqldbuser => "ftpusers",
	sqldbpass => "mypassword",
}
```

For any directives which aren't directly supported by the module, use the
additional `directives` hash parameter :

```puppet
class { '::proftpd::mod_sql':
	sqldbhost => "localhost",
	sqldbname => "ftpusers",
	sqldbuser => "ftpusers",
	sqldbpass => "mypassword",
    directives  => {
      'SQLUserWhereClause' => '"LoginAllowed = \'true\'"',
    },
}
```
