#!/usr/bin/env bash

puppet epp render deluged.service.epp --values '{ service_user => deluge, service_umask => "002" }'
