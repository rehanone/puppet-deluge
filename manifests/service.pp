class deluge::service () inherits deluge {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  $service_server = $deluge::service_server
  $service_webui = $deluge::service_webui
  $service_user = $deluge::service_user

  case $facts[service_provider] {
    'upstart': {
      file { '/etc/init/deluge.conf':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => epp("${module_name}/service/upstart/deluge.conf.erb"),
        require => User[$service_user],
        notify  => [Service[$service_server], Service[$service_webui]],
      }

      file { '/etc/init/deluge-web.conf':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => epp("${module_name}/service/upstart/deluge-web.conf.epp"),
        require => User[$service_user],
        notify  => [Service[$service_server], Service[$service_webui]],
      }
    }
    'systemd': {
      file { '/etc/init/deluge.conf':
        ensure => absent,
      }

      file { '/etc/init/deluge-web.conf':
        ensure => absent,
      }

      file { '/etc/systemd/system/deluge.service':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => epp("${module_name}/service/systemd/deluge.service.epp"),
        require => User[$service_user],
        notify  => [Service[$service_server], Service[$service_webui]],
      }

      file { '/etc/systemd/system/deluge-web.service':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => epp("${module_name}/service/systemd/deluge-web.service.epp"),
        require => User[$service_user],
        notify  => [Service[$service_server], Service[$service_webui]],
      }
    }
    default: { }
  }

  if $deluge::service_manage == true {
    service { $deluge::service_server:
      ensure    => $deluge::service_ensure,
      enable    => $deluge::service_enable,
      name      => $deluge::service_server,
      provider  => $facts[service_provider],
      subscribe => Class["${module_name}::config"],
    }

    service { $deluge::service_webui:
      ensure    => $deluge::service_ensure,
      enable    => $deluge::service_enable,
      name      => $deluge::service_webui,
      provider  => $facts[service_provider],
      subscribe => Class["${module_name}::config"],
    }
  }
}
