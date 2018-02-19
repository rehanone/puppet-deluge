class deluge::repo () inherits deluge {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $deluge::repo_manage {

    case $::facts[os][family] {
      'RedHat': {
        require epel
        require wget

        wget::retrieve { 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm':
          destination => '/tmp/epel-release',
          verbose     => true,
        }

        wget::retrieve { "${deluge::repo_sources}/${deluge::repo_package}":
          destination => "/tmp/${deluge::repo_package}",
          verbose     => true,
        }
      }
      'Debian': {
        case $::facts[os][name] {
          'Ubuntu': {
            require apt
            apt::ppa { $deluge::repo_sources:
              ensure => $deluge::package_ensure,
            }
          }
          default: {}
        }
      }
      default: {}
    }
  }
}
