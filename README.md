# rehan-deluge

[![Build Status](https://travis-ci.org/rehanone/puppet-deluge.svg?branch=master)](https://travis-ci.com/rehanone/puppet-deluge)

#### Table of Contents
1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
    * [Classes](#classes)
    * [Referances](#referances)
5. [Dependencies](#dependencies)
6. [Development](#development)

## Overview
A Puppet module to install, configure and deploy the latest deluge server or client.

## Module Description
A puppet module for managing the installation and configuration of deluge server and client.

Where possible, this module can be used to ensure the deluge installation is up to date with latest release.
Currently, this feature is supported for the following OSes:

  - Ubuntu (using [ppa:deluge-team/stable](https://launchpad.net/~deluge-team/+archive/ubuntu/stable "ppa:deluge-team/stable") )

## Setup
In order to install `rehan-deluge`, run the following command:
```bash
$ puppet module install rehan-deluge
```
The module does expect all the data to be provided through 'Hiera'. See [Usage](#usage) for examples on how to configure it.

#### Requirements
This module is designed to be as clean and compliant with latest puppet code guidelines.

## Usage

### Classes

#### `deluge`

A basic server install with the defaults would be:

```puppet
class{ 'deluge':
  type => server,
}
```

A basic client install with the defaults would be:

```puppet
class{ 'deluge':
  type => client,
}
```

##### Parameters

* **type**: The install type that can be `server` or `client`. The default value is `client`.
* **repo_manage**: Manage the upstream repository on supported OSes. The default value is `false`.
* **package_ensure**: Ensure the package is installed. The default value is `latest`.
* **package_server**: Server package name for deluge service. The default is `deluged`.
* **package_webui**: Server package name for Deluge WebGUI. The default is `deluge-webui`.
* **package_console**: Server package name for Deluge Console. The default is `deluge-console`.
* **package_client**: Client package name for Deluge Client. The default is `deluge`.
* **service_enable**: Enables the `deluged` service at boot. The default is `true`.
* **service_ensure**: Controls the `deluged` service. The default is `running`.
* **service_manage**: Controls if this module should manage the `deluged` service. The default is `true`.
* **service_server**: Deluge service name for the server. The default is `deluged`.
* **service_webui**: Deluge service name for the WebGUI. The default is `deluge-web`.
* **service_user**: Deluge service user name. The default is `deluge`.
* **service_home**: Deluge service home directory name. The default is `/var/lib/deluge`.
* **service_ports**: Deluge service ports..
* **firewall_manage**: Manage the firewall for service ports if `puppetlabs-firewall` module is used. The default is `false`.

All of this data can be provided through `Hiera`. 


**YAML**
```yaml
---
deluge::type: client
deluge::repo_manage: false
deluge::package_ensure: 'latest'
deluge::package_server: 'deluged'
deluge::package_webui: 'deluge-webui'
deluge::package_console: 'deluge-console'
deluge::package_client: 'deluge'
deluge::service_enable: true
deluge::service_ensure: 'running'
deluge::service_manage: true
deluge::service_server: 'deluged'
deluge::service_webui: 'deluge-web'
deluge::service_user: 'deluge'
deluge::service_home: '/var/lib/deluge'
deluge::service_ports:
  '8112': 'tcp'
  '58846': 'tcp'
  '49152-65535': 'udp'
deluge::firewall_manage: false
```

### Resources

#### `deluge::user`

This resource allows creation of a configuration file `${service_home}/.config/deluge/auth`.

Usage:
```puppet
deluge::user { 'alice':
  password => 'secret',
  level    => '10',
  ensure   => present,
}
```

##### Parameters

* **password** Password for the user.
* **level** User access level.

## Dependencies

* [stdlib][1]
* [concat][2]
* [apt][3]
* [epel][4]
* [wget][5]

[1]:https://forge.puppet.com/puppetlabs/stdlib
[2]:https://forge.puppet.com/puppetlabs/concat
[3]:https://forge.puppet.com/puppetlabs/apt
[4]:https://forge.puppet.com/stahnma/epel
[5]:https://forge.puppet.com/rehan/wget

## Development

You can submit pull requests and create issues through the official page of this module: https://github.com/rehanone/puppet-deluge.
Please do report any bug and suggest new features/improvements.
