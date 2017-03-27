class deluge::params {
  $type            = server
  $repo_manage     = true
  $repo_sources    = {
    ubuntu => 'ppa:deluge-team/ppa',
  }
  $package_ensure  = 'latest'
  $package_server  = 'deluged'
  $package_webui   = 'deluge-webui'
  $package_console = 'deluge-console'
  $package_client  = 'deluge'
  $service_enable  = true
  $service_ensure  = 'running'
  $service_manage  = true
  $service_server  = 'deluge'
  $service_webui   = 'deluge-web'
  $service_user    = 'deluge'
  $service_home    = '/var/lib/deluge'
  $service_ports   = {
    '8112'        => 'tcp',
    '58846'       => 'tcp',
    '49152-65535' => 'udp',
  }
  $firewall_manage = false
}
