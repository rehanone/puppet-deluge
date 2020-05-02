define deluge::user (
  String  $password,
  String  $level,
  Enum[absent, present] $ensure = present,
) {

  $home = $deluge::service_home

  if ($ensure in [ 'present' ]) {
    concat::fragment { "${name}-${level}-${ensure}":
      target  => "${home}/.config/deluge/auth",
      content => "${name}:${password}:${level}",
    }
  }
}
