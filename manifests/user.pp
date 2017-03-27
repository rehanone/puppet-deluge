define deluge::user (
  $password,
  $level,
  $ensure = present,
) {

  if ! ($ensure in [ 'absent', 'present' ]) {
    fail('ensure parameter must be one of absent, present')
  }

  $home   = $deluge::service_home

  if ($ensure in [ 'present' ]) {
    concat::fragment{ "${name}-${level}-${ensure}":
      target  => "${home}/.config/deluge/auth",
      content => "${name}:${password}:${level}",
    }
  }
}
