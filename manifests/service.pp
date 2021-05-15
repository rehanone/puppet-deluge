class deluge::service () inherits deluge {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $deluge::service_manage == true {

    notify { "${deluge::service_server}_service -> Using service provider: ${facts[service_provider]}": }

    case $facts[service_provider] {
      'upstart': {
        file { "/etc/init/${deluge::service_server}.conf":
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => epp("${module_name}/service/upstart/${deluge::service_server}.conf.epp",
            {
              'service_user'  => $deluge::service_user,
              'service_umask' => $deluge::service_server_umask,
            },
          ),
          require => User[$deluge::service_user],
          notify  => [Service[$deluge::service_server], Service[$deluge::service_webui]],
        }

        file { "/etc/init/${deluge::service_webui}.conf":
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => epp("${module_name}/service/upstart/${deluge::service_webui}.conf.epp",
            {
              'service_user'  => $deluge::service_user,
              'service_umask' => $deluge::service_webui_umask,
            },
          ),
          require => User[$deluge::service_user],
          notify  => [Service[$deluge::service_server], Service[$deluge::service_webui]],
        }
      }
      'systemd', 'debian': {
        file { "/etc/init/${deluge::service_server}.conf":
          ensure => absent,
        }

        file { "/etc/init/${deluge::service_webui}.conf":
          ensure => absent,
        }

        file { "/etc/systemd/system/${deluge::service_server}.service":
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => epp("${module_name}/service/systemd/${deluge::service_server}.service.epp",
            {
              'service_user'  => $deluge::service_user,
              'service_umask' => $deluge::service_server_umask,
            },
          ),
          require => User[$deluge::service_user],
          notify  => [Service[$deluge::service_server], Service[$deluge::service_webui]],
        }

        file { "/etc/systemd/system/${deluge::service_webui}.service":
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => epp("${module_name}/service/systemd/${deluge::service_webui}.service.epp",
            {
              'service_user'  => $deluge::service_user,
              'service_umask' => $deluge::service_webui_umask,
            },
          ),
          require => User[$deluge::service_user],
          notify  => [Service[$deluge::service_server], Service[$deluge::service_webui]],
        }
      }
      default: {}
    }

    service { $deluge::service_server:
      ensure    => $deluge::service_ensure,
      enable    => $deluge::service_enable,
      name      => $deluge::service_server,
      provider  => $facts[service_provider],
      subscribe => Class["${module_name}::config"],
    }

    -> service { $deluge::service_webui:
      ensure    => $deluge::service_ensure,
      enable    => $deluge::service_enable,
      name      => $deluge::service_webui,
      provider  => $facts[service_provider],
      subscribe => Class["${module_name}::config"],
    }
  }
}
