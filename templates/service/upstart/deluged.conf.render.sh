#!/usr/bin/env bash

puppet epp render deluged.conf.epp --values '{ service_user => deluge, service_umask => "002" }'
