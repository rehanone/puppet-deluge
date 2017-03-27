class deluge (
  Enum[server, client]
          $type            = $deluge::params::type,
  Boolean $repo_manage     = $deluge::params::repo_manage,
  String  $package_ensure  = $deluge::params::package_ensure,
  String  $package_server  = $deluge::params::package_server,
  String  $package_webui   = $deluge::params::package_webui,
  String  $package_console = $deluge::params::package_console,
  Boolean $service_manage  = $deluge::params::service_manage,
  Enum[stopped, running]
          $service_ensure  = $deluge::params::service_ensure,
  Variant[Enum[mask, manual], Boolean]
          $service_enable  = $deluge::params::service_enable,
  String  $service_server  = $deluge::params::service_server,
  String  $service_webui   = $deluge::params::service_webui,
  String  $service_user    = $deluge::params::service_user,
  Stdlib::Absolutepath
          $service_home    = $deluge::params::service_home,
  Hash[String, String]
          $service_ports   = $deluge::params::service_ports,
  Boolean $firewall_manage = $deluge::params::firewall_manage,
  Hash    $users           = {},
  ) inherits deluge::params {

  if ($package_ensure in [ 'absent', 'purged' ]) {
    class { "${module_name}::install": }
  } else {
    if ($type == server) {
      anchor { "${module_name}::begin": } ->
        class { "${module_name}::repo": } ->
        class { "${module_name}::install": } ->
        class { "${module_name}::config": } ~>
        class { "${module_name}::service": } ->
        class { "${module_name}::logrotate": } ->
        class { "${module_name}::firewall": } ->
      anchor { "${module_name}::end": }
    } else {
      anchor { "${module_name}::begin": } ->
        class { "${module_name}::repo": } ->
        class { "${module_name}::install": } ->
      anchor { "${module_name}::end": }
    }
  }
}