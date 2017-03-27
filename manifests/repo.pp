
class deluge::repo () inherits deluge {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $deluge::repo_manage {

    case $::facts[operatingsystem] {
      'Ubuntu': {
        require apt
        apt::ppa { $deluge::repo_sources[ubuntu]:
          ensure => present,
        }
      }
      default: {}
    }
  }
}
