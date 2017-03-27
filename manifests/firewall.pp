class deluge::firewall () inherits deluge {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $deluge::firewall_manage and defined('::firewall') {
    $deluge::service_ports.each |$port, $proto| {
      firewall { "${port} Allow inbound ${proto} connection on port: ${port}":
        dport  => $port,
        proto  => $proto,
        action => accept,
      }
    }
  }
}
