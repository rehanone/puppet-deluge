class deluge::install () inherits deluge {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if ($deluge::type == server) {

    case $::facts[os][family] {
      'RedHat': {

        if $deluge::package_ensure != absent {
          package { 'epel-release':
            ensure          => $deluge::package_ensure,
            provider        => rpm,
            source          => '/tmp/epel-release',
            install_options => '--replacepkgs',
          } -> package { $deluge::repo_package:
            ensure          => $deluge::package_ensure,
            provider        => rpm,
            source          => "/tmp/${deluge::repo_package}",
            install_options => '--replacepkgs',
          } -> package { $deluge::package_server:
            ensure => $deluge::package_ensure,
            alias  => 'deluge',
          } -> package { $deluge::package_webui:
            ensure => $deluge::package_ensure,
            alias  => 'deluge-webui',
          } -> package { $deluge::package_console:
            ensure => $deluge::package_ensure,
            alias  => 'deluge-console',
          }
        }
      }
      default: {
        package { $deluge::package_server:
          ensure => $deluge::package_ensure,
          alias  => 'deluge',
        }

        package { $deluge::package_webui:
          ensure => $deluge::package_ensure,
          alias  => 'deluge-webui',
        }

        package { $deluge::package_console:
          ensure => $deluge::package_ensure,
          alias  => 'deluge-console',
        }
      }
    }

  } else {

    case $::facts[os][name] {
      'RedHat', 'Fedora', 'CentOS': {
        package { $deluge::package_client:
          ensure   => $deluge::package_ensure,
          provider => rpm,
          source   => "/tmp/${deluge::package_client}",
        }
      }
      default: {
        package { $deluge::package_client:
          ensure => $deluge::package_ensure,
        }
      }
    }
  }
}
