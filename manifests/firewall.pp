class deluge::firewall () inherits deluge {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $deluge::firewall_manage {
    $deluge::service_ports.each |$port, $proto| {
      if defined('::firewall') {
        firewall { "${port} - DELUGE - Allow inbound ${proto} connection on port: ${port}":
          dport  => $port,
          proto  => $proto,
          action => accept,
        }
      }

      if defined('::ferm') {
        $p = regsubst($port, '-', ':', 'G')
        ferm::rule { "DELUGE - Allow inbound ${proto} connection on port: ${port}":
          chain  => 'INPUT',
          dport  => "(${p})",
          proto  => $proto,
          action => 'ACCEPT',
        }
      }
    }
  }
}
