class deluge::install () inherits deluge {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if ($deluge::type == server) {
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
  } else {
    package { $deluge::package_client:
      ensure => $deluge::package_ensure,
    }
  }
}
