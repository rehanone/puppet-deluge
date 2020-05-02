class deluge (
  Enum[server, client] $type,
  Boolean $repo_manage,
  String  $package_ensure,
  String  $package_server,
  String  $package_webui,
  String  $package_console,
  String  $package_client,
  Boolean $service_manage,
  Enum[stopped, running] $service_ensure,
  Variant[Enum[mask, manual], Boolean] $service_enable,
  String  $service_server,
  String  $service_webui,
  String  $service_user,
  String  $service_server_umask,
  String  $service_webui_umask,
  Stdlib::Absolutepath $service_home,
  Array[
    Struct[
      {
        port =>
          Variant[
          Stdlib::Port,
          Array[Stdlib::Port],
          Pattern['^\d*:\d+$'],
        ],
        protocol => Enum[tcp, udp],
      }
    ]
  ]       $service_ports,
  Boolean $firewall_manage,
  Optional[String] $repo_sources = undef,
  Optional[String] $repo_package = undef,
  Hash    $users                 = {},
) {

  if ($type == server) {
    anchor { "${module_name}::begin": }
    -> class { "${module_name}::repo": }
    -> class { "${module_name}::install": }
    -> class { "${module_name}::config": }
    ~> class { "${module_name}::service": }
    -> class { "${module_name}::logrotate": }
    -> class { "${module_name}::firewall": }
    -> anchor { "${module_name}::end": }
  } else {
    anchor { "${module_name}::begin": }
    -> class { "${module_name}::repo": }
    -> class { "${module_name}::install": }
    -> anchor { "${module_name}::end": }
  }
}
