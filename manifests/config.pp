class deluge::config () inherits deluge {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if !defined(User[$deluge::service_user]) {
    user { 'deluge':
      ensure => present,
      system => true,
    }
  }

  file { $deluge::service_home:
    ensure  => directory,
    owner   => $deluge::service_user,
    group   => $deluge::service_user,
    mode    => '0755',
    require => User[$deluge::service_user],
  }
  -> file { "${deluge::service_home}/.config":
    ensure  => directory,
    owner   => $deluge::service_user,
    group   => $deluge::service_user,
    mode    => '0750',
    require => User[$deluge::service_user],
  }
  -> file { "${deluge::service_home}/.config/deluge":
    ensure  => directory,
    owner   => $deluge::service_user,
    group   => $deluge::service_user,
    mode    => '0750',
    require => User[$deluge::service_user],
    notify  => Service[$deluge::service_server],
  }
  -> exec { 'deluge-console-allow-remote':
    command     => "deluge-console \"config -s allow_remote True\"",
    path        => '/usr/bin',
    subscribe   => File["${deluge::service_home}/.config/deluge"],
    refreshonly => true,
    group       => $deluge::service_user,
    notify      => Service[$deluge::service_server],
  }
  -> concat { "${deluge::service_home}/.config/deluge/auth":
    ensure_newline => true,
    owner          => $deluge::service_user,
    group          => $deluge::service_user,
    mode           => '0750',
  }
  concat::fragment { 'deluge_default_user':
    target  => "${deluge::service_home}/.config/deluge/auth",
    content => 'localclient:690f6fe7c1262f4282e84ab5dee7e8f92eed3855:10',
  }

  create_resources('deluge::user', $deluge::users)
}
