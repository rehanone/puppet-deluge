#!/usr/bin/env bash

puppet epp render deluge.service.epp --values '{ service_user => deluge }'
