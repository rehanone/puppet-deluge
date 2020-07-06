class deluge::firewall () inherits deluge {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $deluge::firewall_manage {
    $deluge::service_ports.each |$entry| {
      $port = $entry[port]
      $proto = $entry[protocol]
      $p = regsubst("${port.convert_to(String)}", ':', '-', 'G')
      if defined('::firewall') {
        firewall { "${port} - DELUGE - Allow inbound ${proto} connection on port: ${port}":
          dport  => $p,
          proto  => $proto,
          action => accept,
        }
      }

      if defined('::ferm') {
        ferm::rule { "DELUGE - Allow inbound ${proto} connection on port: ${port}":
          chain  => 'INPUT',
          dport  => $port,
          proto  => $proto,
          action => 'ACCEPT',
        }
      }
    }
  }
}
