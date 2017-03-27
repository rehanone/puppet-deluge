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

    file { '/etc/logrotate.d/deluge':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => "puppet:///modules/${module_name}/deluge",
      require => User[$deluge::service_user],
    }
  } else {
    file { '/etc/logrotate.d/deluge':
      ensure => absent,
    }
  }
}
