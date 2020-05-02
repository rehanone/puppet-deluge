class deluge::logrotate () inherits deluge {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if !($deluge::package_ensure in [ 'absent', 'purged' ]) {
    file { '/var/log/deluge':
      ensure  => directory,
      owner   => $deluge::service_user,
      group   => $deluge::service_user,
      mode    => '0750',
      require => User[$deluge::service_user],
    }


    case $facts[service_provider] {
      'upstart': {
        file { '/etc/logrotate.d/deluge':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => epp("${module_name}/logrotate/deluge.epp",
            {
              'service_ctl' => initctl,
            },
          ),
          require => User[$deluge::service_user],
        }
      }
      'systemd': {
        file { '/etc/logrotate.d/deluge':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => epp("${module_name}/logrotate/deluge.epp",
            {
              'service_ctl' => systemctl,
            },
          ),
          require => User[$deluge::service_user],
        }
      }
      default: {}
    }
  } else {
    file { '/etc/logrotate.d/deluge':
      ensure => absent,
    }
  }
}
