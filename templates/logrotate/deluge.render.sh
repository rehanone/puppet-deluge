#!/usr/bin/env bash

puppet epp render deluge.epp --values '{ service_ctl => systemctl }'
