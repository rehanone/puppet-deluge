class deluge::config () inherits deluge {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  $user = $deluge::service_user
  $home = $deluge::service_home
  $service = $deluge::service_server

  if ! defined(User[$user]) {
    user {'deluge':
      ensure => present,
      system => true,
    }
  }

  file { $home:
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0755',
    require => User[$user],
  }
  -> file { "${home}/.config":
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0750',
    require => User[$user],
  }
  -> file { "${home}/.config/deluge":
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0750',
    require => User[$user],
    notify  => Service[$service],
  }
  -> exec { 'deluge-console-allow-remote':
    command     => "deluge-console \"config -s allow_remote True\"",
    path        => '/usr/bin',
    subscribe   => File["${home}/.config/deluge"],
    refreshonly => true,
    group       => $user,
    notify      => Service[$service],
  }
  -> concat { "${home}/.config/deluge/auth":
    ensure_newline => true,
    owner          => $user,
    group          => $user,
    mode           => '0750',
  }
  concat::fragment { 'deluge_default_user':
    target  => "${home}/.config/deluge/auth",
    content => 'localclient:690f6fe7c1262f4282e84ab5dee7e8f92eed3855:10',
  }

  create_resources('deluge::user', $deluge::users)
}
