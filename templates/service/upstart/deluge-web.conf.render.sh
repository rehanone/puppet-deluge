#!/usr/bin/env bash

puppet epp render deluge-web.conf.epp --values '{ service_user => deluge, service_umask => "002" }'
